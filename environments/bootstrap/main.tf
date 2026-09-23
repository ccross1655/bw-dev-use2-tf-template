locals {
  config = yamldecode(file("${path.root}/../../config/tenant.yaml"))
}

module "management_groups" {
  source = "../../modules/management_groups"

  root_name             = local.config.tenant.root_name
  root_display_name     = local.config.tenant.root_name
  platform_name         = local.config.management_groups.platform
  platform_display_name = local.config.management_groups.platform
  platform_ops_name     = local.config.management_groups.platform_ops
  landing_zone_name     = local.config.management_groups.landing_zones
  nonprod_name          = local.config.management_groups.nonprod
  prod_name             = local.config.management_groups.prod
  sandbox_name          = local.config.management_groups.sandbox
}

module "policy_baseline" {
  source = "../../modules/policy_baseline"

  scope_id                    = module.management_groups.root_id
  allowed_locations           = local.config.policies.allowed_locations
  allowed_locations_policy_id = local.config.policies.allowed_locations_definition_id
  require_tag_policy_id       = local.config.policies.require_tags_definition_id
}

module "subscription_assignments" {
  source = "../../modules/subscription_assignments"

  assignments = {
    shared = {
      subscription_id     = local.config.subscriptions.shared.id
      management_group_id = module.management_groups.platform_ops_id
      display_name        = "Shared / Operations"
    }
    dev = {
      subscription_id     = local.config.subscriptions.dev.id
      management_group_id = module.management_groups.nonprod_id
      display_name        = "Dev"
    }
    test = {
      subscription_id     = local.config.subscriptions.test.id
      management_group_id = module.management_groups.nonprod_id
      display_name        = "Test"
    }
    prod = {
      subscription_id     = local.config.subscriptions.prod.id
      management_group_id = module.management_groups.prod_id
      display_name        = "Prod"
    }
  }
}
