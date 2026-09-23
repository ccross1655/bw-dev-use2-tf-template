variable "root_name" {
  description = "Tenant root management group name."
  type        = string
  default     = "mg-bw"
}

variable "root_display_name" {
  description = "Display name shown in Azure portal."
  type        = string
  default     = "mg-bw"
}

variable "platform_name" {
  description = "Platform management group name."
  type        = string
  default     = "mg-bw-platform"
}

variable "platform_display_name" {
  description = "Display name for the platform management group."
  type        = string
  default     = "mg-bw-platform"
}

variable "platform_ops_name" {
  description = "Platform operations management group name."
  type        = string
  default     = "mg-bw-platform-ops"
}

variable "landing_zone_name" {
  description = "Landing zone management group name."
  type        = string
  default     = "mg-bw-landingzones"
}

variable "nonprod_name" {
  description = "Non-production landing zone group name."
  type        = string
  default     = "mg-bw-lz-nonprod"
}

variable "prod_name" {
  description = "Production landing zone group name."
  type        = string
  default     = "mg-bw-lz-prod"
}

variable "sandbox_name" {
  description = "Sandbox management group name."
  type        = string
  default     = "mg-bw-sandbox"
}
