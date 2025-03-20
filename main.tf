resource "azurerm_resource_group" "rg" {
  name     = "my-resource-group"
  location = "East US"
}

resource "azurerm_storage_account" "storage" {
  name                     = "mystorageaccounttt489"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  depends_on = [azurerm_resource_group.rg] # Explicit dependency
}

resource "azurerm_storage_container" "tfstate" {
  name                  = "tfstate"
  storage_account_id    = azurerm_storage_account.storage.id
  container_access_type = "private"
}

module "vnet_region1" {
  source               = "./modules/vnet"
  vnet_name            = "vnet-region1"
  region               = "East US"
  resource_group_name  = azurerm_resource_group.rg.name
  address_space              = ["10.0.0.0/16"]  # Address space for vnet-region1
  subnet_address_space =   ["10.0.1.0/24"]
}

module "vnet_region2" {
  source               = "./modules/vnet"
  vnet_name            = "vnet-region2"
  region               = "West US"
  resource_group_name  = azurerm_resource_group.rg.name
  address_space              = ["10.1.0.0/16"]  # Address space for vnet-region2
  subnet_address_space =   ["10.1.1.0/24"]
}

module "vnet_peering" {
  source               = "./modules/peering"
  vnet1_name           = module.vnet_region1.vnet_name
  vnet2_name           = module.vnet_region2.vnet_name
  resource_group_name  = azurerm_resource_group.rg.name
  vnet1_id             = module.vnet_region1.vnet_id
  vnet2_id             = module.vnet_region2.vnet_id
}


module "aks_cluster_region1" {
  resource_group_name  = azurerm_resource_group.rg.name
  source         = "./modules/aks-cluster"
  region         = "East US"  # EKS Cluster region
  vnet_id        = module.vnet_region1.vnet_id
  cluster_name   = "aks-cluster-region1"
  subnet_id = module.vnet_region1.subnet_address_space
  service_cidr         = "10.2.0.0/16"  # Choose a service CIDR that doesn't overlap with subnets
  dns_service_ip    = "10.2.0.10" 
}
module "aks_cluster_region2" {
  resource_group_name  = azurerm_resource_group.rg.name
  source         = "./modules/aks-cluster"
  region         = "West US"  # EKS Cluster regionx x   
  vnet_id        = module.vnet_region2.vnet_id
  subnet_id = module.vnet_region2.subnet_address_space
  cluster_name   = "aks-cluster-region2"
  service_cidr         = "10.3.0.0/16"  # Choose a service CIDR that doesn't overlap with subnets
  dns_service_ip    = "10.3.0.10"  # Must be within 10.3.0.0/16 but outside pod range
} 

