module "prod_network" {
  source = "../../../modules/network"

  name_prefix           = "bw-prod-eus-infra"
  primary_location      = "eastus"
  dr_location           = "centralus"
  primary_address_space = "10.180.100.0/24"
  dr_address_space      = "10.190.100.0/24"
  common_tags           = local.common_tags
}

output "network_vnet_ids" {
  value = module.prod_network.vnet_ids
}