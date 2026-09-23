resource "azurerm_user_assigned_identity" "platform" {
  name                = "${var.prefix}-id-${var.env}-${var.region_token}"
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_role_assignment" "contributor" {
  scope                = var.scope
  role_definition_name = "Contributor"
  principal_id         = azurerm_user_assigned_identity.platform.principal_id
}

output "client_id" {
  value = azurerm_user_assigned_identity.platform.client_id
}

output "principal_id" {
  value = azurerm_user_assigned_identity.platform.principal_id
}
