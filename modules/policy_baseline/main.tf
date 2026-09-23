resource "azurerm_management_group_policy_assignment" "allowed_locations" {
  name                 = "${var.prefix}-allowed-locations"
  management_group_id  = var.scope_id
  policy_definition_id = var.allowed_locations_policy_id
  description          = "Restrict Azure deployment regions to the approved list."
  display_name         = "Allowed locations"

  parameters = jsonencode({
    listOfAllowedLocations = {
      value = var.allowed_locations
    }
  })
}

resource "azurerm_management_group_policy_assignment" "require_tags" {
  name                 = "${var.prefix}-require-tags"
  management_group_id  = var.scope_id
  policy_definition_id = var.require_tag_policy_id
  description          = "Require governance tags on resources and resource groups."
  display_name         = "Require tags"

  parameters = jsonencode({
    tagName = {
      value = "Environment"
    }
  })
}

output "allowed_locations_assignment_id" {
  description = "ID of the allowed locations assignment."
  value       = azurerm_management_group_policy_assignment.allowed_locations.id
}

output "require_tags_assignment_id" {
  description = "ID of the require tags assignment."
  value       = azurerm_management_group_policy_assignment.require_tags.id
}
