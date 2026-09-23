module "dev_network" {
  source = "../../../modules/network"

  name_prefix           = "bw-${local.env}-${local.region_token}-${local.proj}"
  primary_location      = local.config.regions.primary.location
  dr_location           = local.config.regions.dr.location
  primary_address_space = local.environment.primary_address_space
  dr_address_space      = local.environment.dr_address_space
  common_tags           = local.common_tags
}

output "network_vnet_ids" {
  value = module.dev_network.vnet_ids
}