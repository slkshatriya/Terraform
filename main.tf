terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }

}
provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "my-rg" {
  name     = "my-resources"
  location = "East US"
  tags = {
    environment = "dev"
  }
}

resource "azurerm_virtual_network" "my-vnet" {
  name                = "my-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.my-rg.location
  resource_group_name = azurerm_resource_group.my-rg.name

  tags = {
    environment = "dev"
  }
}

resource "azurerm_logic_app_workflow" "my-logic-app" {
  name                = "my-logic-app"
  location            = azurerm_resource_group.my-rg.location
  resource_group_name = azurerm_resource_group.my-rg.name

  tags = {
    environment = "dev"
  }
}