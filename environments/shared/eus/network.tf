module "shared_network" {
  source = "../../../modules/network"

  name_prefix           = "bw-shared-eus-infra"
  primary_location      = "eastus"
  dr_location           = "centralus"
  primary_address_space = "10.180.240.0/22"
  dr_address_space      = "10.190.240.0/22"
  common_tags           = local.common_tags
}

output "network_vnet_ids" {
  value = module.shared_network.vnet_ids
}