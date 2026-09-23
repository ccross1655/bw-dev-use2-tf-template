module "platform_identity" {
  source = "../../../modules/identity"

  prefix              = "bw"
  env                 = "shared"
  region_token        = "eus"
  location            = "eastus"
  resource_group_name = module.shared_platform.resource_group_name
  scope               = "/subscriptions/00000000-0000-0000-0000-000000000000"
}

output "platform_identity_client_id" {
  value = module.platform_identity.client_id
}
