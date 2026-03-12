# =============================================================================
# DEV ENVIRONMENT VARIABLES
# =============================================================================
# This file contains values specific to the "dev" environment.
# Every terragrunt.hcl in this folder reads these values using:
#   read_terragrunt_config(find_in_parent_folders("env.hcl"))
#
# To create a "prod" environment, simply copy this folder, and change
# the values below (e.g., environment = "prod", location = "West US").
# =============================================================================

locals {
  environment = "dev"
  location    = "East US"

  tags = {
    environment = "dev"
    managed_by  = "terragrunt"
  }
}
