# Input variables for the Virtual Network module.

variable "vnet_name" {
  description = "The name of the virtual network"
  type        = string
}

variable "address_space" {
  description = "The address space (CIDR blocks) for the virtual network"
  type        = list(string)
}

variable "location" {
  description = "The Azure region where the VNet will be created"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group to place the VNet in"
  type        = string
}

variable "tags" {
  description = "A map of tags to assign to the VNet"
  type        = map(string)
  default     = {}
}
