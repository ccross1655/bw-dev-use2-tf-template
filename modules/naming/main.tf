locals {
  prefix       = "bw-${var.env}-${var.region_token}-${var.proj}"
  prefix_alnum = "bw${var.env}${var.region_token}${var.proj}"

  qualifier = var.qualifier == "" ? "" : "-${var.qualifier}"
  instance  = format("%02d", var.instance_number)

  resource_name = "${local.prefix}-${var.resource_type}${local.qualifier}-${local.instance}"
  storage_name  = "${local.prefix_alnum}st${local.qualifier}${local.instance}"
  keyvault_name = "kv-bw-${var.env}-${var.region_token}-${var.proj}"
}
