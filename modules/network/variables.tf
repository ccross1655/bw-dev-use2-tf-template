variable "name_prefix" {
  description = "Environment and workload prefix used in Azure resource names."
  type        = string
}

variable "primary_location" {
  description = "Primary Azure region."
  type        = string
}

variable "dr_location" {
  description = "Disaster recovery Azure region."
  type        = string
}

variable "primary_address_space" {
  description = "Primary VNet CIDR from the approved address plan."
  type        = string
}

variable "dr_address_space" {
  description = "DR VNet CIDR from the approved address plan."
  type        = string
}

variable "common_tags" {
  description = "Common Azure tags applied to network resources."
  type        = map(string)
}