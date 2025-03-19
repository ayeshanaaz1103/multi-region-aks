# Output the VNet ID
output "vnet_id" {
  value = azurerm_virtual_network.vnet.id
}

output "vnet_name" {
  description = "The name of the virtual network"
  value       = azurerm_virtual_network.vnet.name
}

output "subnet_address_space" {
  description = "The address prefix of the default subnet."
  value       = azurerm_subnet.default_subnet.id
}