variable "env" {
  description = "Deployment environment."
  type        = string

  validation {
    condition     = contains(["dev", "test", "prod", "shared"], var.env)
    error_message = "env must be one of: dev, test, prod, shared."
  }
}

variable "region_token" {
  description = "Azure region token used in naming."
  type        = string
  default     = "eus"

  validation {
    condition     = contains(["eus", "wus2"], var.region_token)
    error_message = "region_token must be eus or wus2."
  }
}

variable "location" {
  description = "Azure region for the workload resources."
  type        = string
  default     = "eastus"
}

variable "proj" {
  description = "Project identifier used for naming."
  type        = string
}

variable "subscription_name" {
  description = "Logical Azure subscription name for environment mapping."
  type        = string
}

variable "management_group_id" {
  description = "Management group ID associated with this landing zone."
  type        = string
}

variable "workload_name" {
  description = "Logical workload name."
  type        = string
  default     = "platform"
}

variable "common_tags" {
  description = "Common Azure tags to apply to all resources."
  type        = map(string)
}

variable "log_analytics_sku" {
  description = "SKU for the Log Analytics workspace."
  type        = string
  default     = "PerGB2018"
}
