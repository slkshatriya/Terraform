# Input variables for the Logic App module.

variable "logic_app_name" {
  description = "The name of the Logic App workflow"
  type        = string
}

variable "location" {
  description = "The Azure region where the Logic App will be created"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group to place the Logic App in"
  type        = string
}

variable "tags" {
  description = "A map of tags to assign to the Logic App"
  type        = map(string)
  default     = {}
}
