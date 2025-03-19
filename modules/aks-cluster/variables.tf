variable "region" {
  description = "The Azure region where the AKS cluster will be created"
  type        = string
}

variable "vnet_id" {
  description = "VNet ID where the AKS cluster will be deployed"
  type        = string
}

variable "subnet_id" {
  description = "List of subnet IDs for AKS cluster nodes"
  type        = string
}

variable "cluster_name" {
  description = "The name of the AKS cluster"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the existing resource group"
  type        = string
}

variable "service_cidr" {
  description = "The CIDR block for the AKS service network"
  type        = string
}


variable "dns_service_ip" {
  description = "The DNS service IP address for AKS"
  type        = string
}