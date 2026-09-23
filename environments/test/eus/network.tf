module "test_network" {
  source = "../../../modules/network"

  name_prefix           = "bw-test-eus-infra"
  primary_location      = "eastus"
  dr_location           = "centralus"
  primary_address_space = "10.180.200.0/24"
  dr_address_space      = "10.190.200.0/24"
  common_tags           = local.common_tags
}

output "network_vnet_ids" {
  value = module.test_network.vnet_ids
}