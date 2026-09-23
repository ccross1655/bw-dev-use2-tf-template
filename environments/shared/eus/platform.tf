module "platform_identity" {
  source = "../../../modules/identity"

  prefix              = "bw"
  env                 = local.env
  region_token        = local.region_token
  location            = local.location
  resource_group_name = module.shared_platform.resource_group_name
  scope               = "/subscriptions/${local.config.subscriptions.shared.id}"
}

output "platform_identity_client_id" {
  value = module.platform_identity.client_id
}
