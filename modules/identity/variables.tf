variable "prefix" {
  description = "Prefix used for the managed identity name."
  type        = string
  default     = "bw"
}

variable "env" {
  description = "Target environment."
  type        = string
}

variable "region_token" {
  description = "Azure region token."
  type        = string
}

variable "location" {
  description = "Azure region."
  type        = string
}

variable "resource_group_name" {
  description = "Resource group where the identity is created."
  type        = string
}

variable "scope" {
  description = "Scope for role assignment."
  type        = string
}
