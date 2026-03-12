# =============================================================================
# TERRAGRUNT CONFIG — DEV LOGIC APP
# =============================================================================

# Inherit remote state + provider from root
include "root" {
  path = find_in_parent_folders()
}

# Load environment variables
locals {
  env_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
}

# Point to the reusable Logic App module
terraform {
  source = "../../../modules/logic-app"
}

# Dependency on resource-group (must exist before Logic App)
dependency "resource_group" {
  config_path = "../resource-group"

  mock_outputs = {
    resource_group_name     = "mock-rg"
    resource_group_location = "East US"
  }
}

# Pass inputs to the Logic App module
inputs = {
  logic_app_name      = "my-logic-app"
  location            = dependency.resource_group.outputs.resource_group_location
  resource_group_name = dependency.resource_group.outputs.resource_group_name
  tags                = local.env_vars.locals.tags
}
