provider "azurerm" {
  features {}
}

locals {
  config       = yamldecode(file("${path.root}/../../../config/tenant.yaml"))
  environment  = local.config.environments.test
  env          = "test"
  region_token = local.config.regions.primary.token
  location     = local.config.regions.primary.location
  proj         = local.environment.project
  common_tags  = merge(local.config.tags, { Environment = local.env, Region = local.region_token })
}

module "test_platform" {
  source = "../../../modules/landing_zone"

  env                 = local.env
  region_token        = local.region_token
  location            = local.location
  proj                = local.proj
  subscription_name   = local.config.subscriptions.test.name
  management_group_id = local.config.management_groups[local.environment.management_group]
  common_tags         = local.common_tags
}

output "resource_group_name" {
  value = module.test_platform.resource_group_name
}

output "management_group_name" {
  value = module.test_platform.management_group_name
}
