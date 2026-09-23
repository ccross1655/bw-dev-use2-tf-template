resource "azurerm_management_group" "root" {
  name                       = var.root_name
  display_name               = var.root_display_name
  parent_management_group_id = null
}

resource "azurerm_management_group" "platform" {
  name                       = var.platform_name
  display_name               = var.platform_display_name
  parent_management_group_id = azurerm_management_group.root.id
}

resource "azurerm_management_group" "platform_ops" {
  name                       = var.platform_ops_name
  display_name               = var.platform_ops_name
  parent_management_group_id = azurerm_management_group.platform.id
}

resource "azurerm_management_group" "landing_zones" {
  name                       = var.landing_zone_name
  display_name               = var.landing_zone_name
  parent_management_group_id = azurerm_management_group.root.id
}

resource "azurerm_management_group" "nonprod" {
  name                       = var.nonprod_name
  display_name               = var.nonprod_name
  parent_management_group_id = azurerm_management_group.landing_zones.id
}

resource "azurerm_management_group" "prod" {
  name                       = var.prod_name
  display_name               = var.prod_name
  parent_management_group_id = azurerm_management_group.landing_zones.id
}

resource "azurerm_management_group" "sandbox" {
  name                       = var.sandbox_name
  display_name               = var.sandbox_name
  parent_management_group_id = azurerm_management_group.root.id
}

output "root_id" {
  description = "ID of the tenant root management group."
  value       = azurerm_management_group.root.id
}

output "platform_id" {
  description = "ID of the platform management group."
  value       = azurerm_management_group.platform.id
}

output "platform_ops_id" {
  description = "ID of the platform operations management group."
  value       = azurerm_management_group.platform_ops.id
}

output "landing_zones_id" {
  description = "ID of the landing zones management group."
  value       = azurerm_management_group.landing_zones.id
}

output "nonprod_id" {
  description = "ID of the non-production management group."
  value       = azurerm_management_group.nonprod.id
}

output "prod_id" {
  description = "ID of the production management group."
  value       = azurerm_management_group.prod.id
}

output "sandbox_id" {
  description = "ID of the sandbox management group."
  value       = azurerm_management_group.sandbox.id
}
