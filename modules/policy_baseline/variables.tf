variable "scope_id" {
  description = "Scope at which the baseline policy assignments should be applied."
  type        = string
}

variable "allowed_locations" {
  description = "Allowed Azure regions for the environment."
  type        = list(string)
  default     = ["eastus", "westus2"]
}

variable "allowed_locations_policy_id" {
  description = "Built-in Azure Policy definition ID for allowed locations. Supply the Azure policy id for your tenant."
  type        = string
  default     = "/providers/Microsoft.Authorization/policyDefinitions/e56962a6-4747-49cd-b67b-..."
}

variable "require_tag_policy_id" {
  description = "Built-in Azure Policy definition ID for requiring a tag. Supply the Azure policy id for your tenant."
  type        = string
  default     = "/providers/Microsoft.Authorization/policyDefinitions/1e30110a-5ceb-460c-a204-c1c3969c6d62"
}

variable "tags_to_require" {
  description = "Tag names that should be required by the baseline policy."
  type        = list(string)
  default     = ["Environment", "Owner", "CostCenter", "ManagedBy"]
}

variable "prefix" {
  description = "Prefix used for policy assignment names."
  type        = string
  default     = "bw"
}
