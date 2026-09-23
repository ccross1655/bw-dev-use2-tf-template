variable "tenant_root_name" {
  type    = string
  default = "mg-bw"
}

variable "location" {
  type    = string
  default = "eastus"
}

variable "allowed_locations" {
  type    = list(string)
  default = ["eastus", "westus2"]
}

variable "env" {
  type    = string
  default = "shared"
}

variable "project_code" {
  type    = string
  default = "infra"
}

variable "owner" {
  type    = string
  default = "ops@example.com"
}

variable "cost_center" {
  type    = string
  default = "0000"
}
