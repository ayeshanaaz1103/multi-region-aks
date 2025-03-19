terraform {

  backend "azurerm" {
  resource_group_name  = "my-resource-group"
  storage_account_name = "mystorageaccounttt489"
  container_name       = "tfstate"
  key                  = "terraform.tfstate"
}

}