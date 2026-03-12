# =============================================================================
# ROOT TERRAGRUNT CONFIGURATION
# =============================================================================
# This file is the "parent" config. Every child terragrunt.hcl in subdirectories
# (like dev/resource-group/terragrunt.hcl) will automatically inherit this
# when they use: include "root" { path = find_in_parent_folders() }
#
# It does TWO main things:
#   1. Configures remote state (so .tfstate files are stored in Azure Storage)
#   2. Generates the provider block (so you don't repeat it in every module)
# =============================================================================

# -----------------------------------------------------------------------------
# REMOTE STATE CONFIGURATION
# -----------------------------------------------------------------------------
# This tells Terragrunt to store Terraform state in an Azure Storage Account.
# The "key" uses the folder path, so each module gets its own state file:
#   - dev/resource-group    → state key: "dev/resource-group/terraform.tfstate"
#   - dev/virtual-network   → state key: "dev/virtual-network/terraform.tfstate"
#   - dev/logic-app         → state key: "dev/logic-app/terraform.tfstate"
#
# IMPORTANT: Change "tfstatestore<random>" to a globally unique name!
# -----------------------------------------------------------------------------
remote_state {
  backend = "azurerm"
  config = {
    resource_group_name  = "terraform-state-rg"
    storage_account_name = "tfstatestrssing193"
    container_name       = "tfstate"
    key                  = "${path_relative_to_include()}/terraform.tfstate"
  }

  # This auto-generates a "backend.tf" file in each module directory
  # so Terraform knows where to store its state.
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
}

# -----------------------------------------------------------------------------
# PROVIDER GENERATION
# -----------------------------------------------------------------------------
# Instead of writing "provider azurerm { features {} }" in every module,
# Terragrunt auto-generates a "provider.tf" file for you.
# This is the DRY (Don't Repeat Yourself) benefit of Terragrunt!
# -----------------------------------------------------------------------------
generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "azurerm" {
  features {}
}
EOF
}
