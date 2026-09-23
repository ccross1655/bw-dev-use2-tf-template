output "root_management_group_id" {
  description = "Root management group ID for the Azure tenant."
  value       = module.management_groups.root_id
}

output "platform_management_group_id" {
  description = "Platform management group ID."
  value       = module.management_groups.platform_id
}

output "platform_ops_management_group_id" {
  description = "Platform operations management group ID."
  value       = module.management_groups.platform_ops_id
}

output "nonprod_management_group_id" {
  description = "Non-production landing-zone management group ID."
  value       = module.management_groups.nonprod_id
}

output "prod_management_group_id" {
  description = "Production landing-zone management group ID."
  value       = module.management_groups.prod_id
}

output "subscription_assignments" {
  description = "Subscription to management group relationships created by the bootstrap module."
  value       = module.subscription_assignments.associations
}
