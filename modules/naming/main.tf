data "azurerm_client_config" "current" {}

resource "time_static" "created" {}

locals {
  prefix       = "bw-${var.env}-${var.region_token}-${var.proj}"
  prefix_alnum = "bw${var.env}${var.region_token}${var.proj}"

  qualifier = var.qualifier == "" ? "" : "-${var.qualifier}"
  instance  = format("%02d", var.instance_number)

  resource_name = "${local.prefix}-${var.resource_type}${local.qualifier}-${local.instance}"
  storage_name  = "${local.prefix_alnum}st${local.qualifier}${local.instance}"
  keyvault_name = "kv-bw-${var.env}-${var.region_token}-${var.proj}"

  common_tags = {
    Environment    = var.env
    Region         = var.region_token
    Project        = var.proj
    Product        = "Global"
    ProductVersion = "1.0"
    Owner          = "ops@example.com"
    CostCenter     = "0000"
    ManagedBy      = "Terraform"
    CreatedDate    = time_static.created.rfc3339
    CreatedBy      = data.azurerm_client_config.current.object_id
    Version        = "1.${formatdate("MMDDYY.hhmm", timestamp())}"
  }
}
