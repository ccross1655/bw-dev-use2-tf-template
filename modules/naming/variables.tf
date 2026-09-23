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

variable "proj" {
  description = "Three to six character project code in lowercase letters and numbers."
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9]{3,6}$", var.proj))
    error_message = "proj must be 3-6 lowercase characters or digits, no hyphens."
  }
}

variable "qualifier" {
  description = "Optional resource qualifier to disambiguate names."
  type        = string
  default     = ""
}

variable "instance_number" {
  description = "Two-digit instance number suffix."
  type        = number
  default     = 1

  validation {
    condition     = var.instance_number >= 1 && var.instance_number <= 99
    error_message = "instance_number must be between 1 and 99."
  }
}

variable "resource_type" {
  description = "Resource token, for example rg, vnet, nsg, kv, st."
  type        = string
  default     = "rg"
}

variable "location" {
  description = "Azure region location for the resource."
  type        = string
  default     = "eastus"
}
