# vnet_module.tf
resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  location            = var.region
  address_space       =  var.address_space
  resource_group_name = var.resource_group_name
}

resource "azurerm_subnet" "default_subnet" {
  name                 = "default"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.subnet_address_space
}