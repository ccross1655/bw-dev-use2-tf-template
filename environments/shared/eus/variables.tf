variable "subscription_id" {
  description = "Azure subscription ID for this environment."
  type        = string
  default     = "00000000-0000-0000-0000-000000000000"
}

variable "environment" {
  description = "Environment name."
  type        = string
  default     = "shared"
}

variable "location" {
  description = "Primary Azure region."
  type        = string
  default     = "eastus"
}

variable "project" {
  description = "Project name used for naming."
  type        = string
  default     = "infra"
}

variable "owner" {
  description = "Owner or team."
  type        = string
  default     = "ops@example.com"
}

variable "cost_center" {
  description = "Finance cost center."
  type        = string
  default     = "0000"
}
