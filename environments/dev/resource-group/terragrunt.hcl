# =============================================================================
# TERRAGRUNT CONFIG — DEV RESOURCE GROUP
# =============================================================================

# -----------------------------------------------------------------------------
# INCLUDE ROOT CONFIG
# -----------------------------------------------------------------------------
# "find_in_parent_folders()" walks UP the directory tree until it finds
# a terragrunt.hcl file. It finds: environments/terragrunt.hcl
# This gives us the remote state config + provider block automatically.
# -----------------------------------------------------------------------------
include "root" {
  path = find_in_parent_folders()
}

# -----------------------------------------------------------------------------
# LOAD ENVIRONMENT VARIABLES
# -----------------------------------------------------------------------------
# "find_in_parent_folders("env.hcl")" walks UP to find env.hcl
# It finds: environments/dev/env.hcl
# This gives us: location, environment, tags
# -----------------------------------------------------------------------------
locals {
  env_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
}

# -----------------------------------------------------------------------------
# TERRAFORM MODULE SOURCE
# -----------------------------------------------------------------------------
# This tells Terragrunt which Terraform module to use.
# The path is relative to THIS file's location.
# ../../../modules/resource-group → goes up 3 levels then into modules/
# -----------------------------------------------------------------------------
terraform {
  source = "../../../modules/resource-group"
}

# -----------------------------------------------------------------------------
# INPUTS
# -----------------------------------------------------------------------------
# These values get passed as variables to the Terraform module.
# They map to the variables defined in modules/resource-group/variables.tf
# -----------------------------------------------------------------------------
inputs = {
  resource_group_name = "my-resources"
  location            = local.env_vars.locals.location
  tags                = local.env_vars.locals.tags
}
