# Outputs from the Logic App module.

output "logic_app_id" {
  description = "The ID of the created Logic App"
  value       = azurerm_logic_app_workflow.this.id
}

output "logic_app_name" {
  description = "The name of the created Logic App"
  value       = azurerm_logic_app_workflow.this.name
}
