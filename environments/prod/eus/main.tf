provider "azurerm" {
  features {}
}

locals {
  env          = "prod"
  region_token = "eus"
  location     = "eastus"
  proj         = "infra"

  common_tags = {
    Environment    = local.env
    Region         = local.region_token
    Project        = "Global"
    Product        = "Global"
    ProductVersion = "1.0"
    Owner          = "ops@example.com"
    CostCenter     = "0000"
    ManagedBy      = "Terraform"
    CreatedDate    = "2026-09-22T00:00:00Z"
    CreatedBy      = "00000000-0000-0000-0000-000000000000"
    Version        = "1.092226.0000"
  }
}

module "prod_platform" {
  source = "../../../modules/landing_zone"

  env                 = local.env
  region_token        = local.region_token
  location            = local.location
  proj                = local.proj
  subscription_name   = "bw-prod"
  management_group_id = "mg-bw-lz-prod"
  common_tags         = local.common_tags
}

output "resource_group_name" {
  value = module.prod_platform.resource_group_name
}

output "management_group_name" {
  value = module.prod_platform.management_group_name
}
