output "prefix" {
  description = "Standard naming prefix for the environment and project."
  value       = local.prefix
}

output "prefix_alnum" {
  description = "Alphanumeric naming prefix for storage and globally unique resources."
  value       = local.prefix_alnum
}

output "resource_name" {
  description = "Standard full resource name."
  value       = local.resource_name
}

output "storage_name" {
  description = "Storage account name built from the standard naming convention."
  value       = local.storage_name
}

output "keyvault_name" {
  description = "Key Vault name built from the Azure naming standard."
  value       = local.keyvault_name
}

output "common_tags" {
  description = "Common Azure tags required by company policy."
  value       = local.common_tags
}
