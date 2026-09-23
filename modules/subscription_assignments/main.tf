resource "azurerm_management_group_subscription_association" "this" {
  for_each = var.assignments

  management_group_id = each.value.management_group_id
  subscription_id     = each.value.subscription_id
}

output "associations" {
  description = "The created subscription-to-management-group associations."
  value       = { for k, v in azurerm_management_group_subscription_association.this : k => v.id }
}
