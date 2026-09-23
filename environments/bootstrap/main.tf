module "management_groups" {
  source = "../../modules/management_groups"

  root_name             = var.tenant_root_name
  root_display_name     = var.tenant_root_name
  platform_name         = "mg-bw-platform"
  platform_display_name = "mg-bw-platform"
  platform_ops_name     = "mg-bw-platform-ops"
  landing_zone_name     = "mg-bw-landingzones"
  nonprod_name          = "mg-bw-lz-nonprod"
  prod_name             = "mg-bw-lz-prod"
  sandbox_name          = "mg-bw-sandbox"
}

module "policy_baseline" {
  source = "../../modules/policy_baseline"

  scope_id          = module.management_groups.root_id
  allowed_locations = var.allowed_locations
}

module "subscription_assignments" {
  source = "../../modules/subscription_assignments"

  assignments = {
    shared = {
      subscription_id     = "00000000-0000-0000-0000-000000000000"
      management_group_id = module.management_groups.platform_ops_id
      display_name        = "Shared / Operations"
    }
    dev = {
      subscription_id     = "11111111-1111-1111-1111-111111111111"
      management_group_id = module.management_groups.nonprod_id
      display_name        = "Dev"
    }
    test = {
      subscription_id     = "22222222-2222-2222-2222-222222222222"
      management_group_id = module.management_groups.nonprod_id
      display_name        = "Test"
    }
    prod = {
      subscription_id     = "33333333-3333-3333-3333-333333333333"
      management_group_id = module.management_groups.prod_id
      display_name        = "Prod"
    }
  }
}
