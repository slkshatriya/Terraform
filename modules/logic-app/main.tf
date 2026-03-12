# This module creates an Azure Logic App Workflow.
# Logic Apps allow you to build automated workflows for integrating apps and data.

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

resource "azurerm_logic_app_workflow" "this" {
  name                = var.logic_app_name
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags
}
