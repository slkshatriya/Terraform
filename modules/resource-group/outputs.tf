# Outputs from the Resource Group module.
# These values can be used by OTHER modules (like VNet, Logic App)
# via Terragrunt's "dependency" block.

output "resource_group_name" {
  description = "The name of the created resource group"
  value       = azurerm_resource_group.this.name
}

output "resource_group_location" {
  description = "The location of the created resource group"
  value       = azurerm_resource_group.this.location
}

output "resource_group_id" {
  description = "The ID of the created resource group"
  value       = azurerm_resource_group.this.id
}
