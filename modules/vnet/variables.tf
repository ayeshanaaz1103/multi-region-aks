variable "vnet_name" {
  description = "The name of the VNet"
  type        = string
}

variable "region" {
  description = "The Azure region for the VNet"
  type        = string
}


variable "resource_group_name" {
  description = "The name of the existing resource group"
  type        = string
}

variable "subnet_address_space" {
  description = "The address space for the virtual network"
  type        = list(string)
}

variable "address_space" {
  description = "The address space for the virtual network"
  type        = list(string)
}
