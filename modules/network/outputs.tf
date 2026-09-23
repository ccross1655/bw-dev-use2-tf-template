output "vnet_ids" {
  description = "Virtual network IDs keyed by primary and DR region."
  value       = { for key, vnet in azurerm_virtual_network.this : key => vnet.id }
}

output "subnet_ids" {
  description = "Subnet IDs keyed by region and subnet role."
  value       = { for key, subnet in azurerm_subnet.this : key => subnet.id }
}

output "resource_group_names" {
  description = "Network resource group names keyed by region."
  value       = { for key, group in azurerm_resource_group.network : key => group.name }
}