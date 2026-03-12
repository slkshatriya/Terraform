# =============================================================================
# TERRAGRUNT CONFIG — DEV VIRTUAL NETWORK
# =============================================================================

# Inherit remote state + provider from root
include "root" {
  path = find_in_parent_folders()
}

# Load environment variables (location, tags, etc.)
locals {
  env_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
}

# Point to the reusable VNet module
terraform {
  source = "../../../modules/virtual-network"
}

# -----------------------------------------------------------------------------
# DEPENDENCY — RESOURCE GROUP
# -----------------------------------------------------------------------------
# This is a KEY Terragrunt feature! It declares that this module depends on
# the resource-group module. Terragrunt will:
#   1. Apply resource-group FIRST (if using "run-all apply")
#   2. Read the outputs from resource-group's state
#   3. Make them available as "dependency.resource_group.outputs.xxx"
#
# "mock_outputs" are fake values used during "terragrunt validate" or "plan"
# when the dependency hasn't been applied yet. They prevent errors.
# -----------------------------------------------------------------------------
dependency "resource_group" {
  config_path = "../resource-group"

  mock_outputs = {
    resource_group_name     = "mock-rg"
    resource_group_location = "East US"
  }
}

# Pass inputs to the VNet module
# Notice: location and resource_group_name come from the DEPENDENCY outputs!
inputs = {
  vnet_name           = "my-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = dependency.resource_group.outputs.resource_group_location
  resource_group_name = dependency.resource_group.outputs.resource_group_name
  tags                = local.env_vars.locals.tags
}
