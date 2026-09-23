terraform {
  required_version = ">= 1.10.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

provider "azurerm" {
  features {}
}

locals {
  regions = {
    primary = {
      location      = var.primary_location
      address_space = var.primary_address_space
    }
    dr = {
      location      = var.dr_location
      address_space = var.dr_address_space
    }
  }

  subnet_definitions = {
    priv_az1 = {
      name          = "snet-priv-az1-01"
      address_start = 0
    }
    priv_az2 = {
      name          = "snet-priv-az2-01"
      address_start = 32
    }
    pub_az1 = {
      name          = "snet-pub-az1-01"
      address_start = 64
    }
    pub_az2 = {
      name          = "snet-pub-az2-01"
      address_start = 96
    }
    pep = {
      name          = "snet-pep-01"
      address_start = 128
    }
  }

  subnet_instances = {
    for item in flatten([
      for region_name, region in local.regions : [
        for subnet_key, subnet in local.subnet_definitions : {
          key            = "${region_name}-${subnet_key}"
          region         = region_name
          subnet_key     = subnet_key
          name           = subnet.name
          address_prefix = cidrsubnet(region.address_space, 5, floor(subnet.address_start / 8))
        }
      ]
    ]) : item.key => item
  }
}

resource "azurerm_resource_group" "network" {
  for_each = local.regions

  name     = "${var.name_prefix}-${each.key}-rg-network-01"
  location = each.value.location
  tags     = var.common_tags
}

resource "azurerm_virtual_network" "this" {
  for_each = local.regions

  name                = "${var.name_prefix}-${each.key}-vnet-01"
  location            = each.value.location
  resource_group_name = azurerm_resource_group.network[each.key].name
  address_space       = [each.value.address_space]
  tags                = var.common_tags
}

resource "azurerm_subnet" "this" {
  for_each = local.subnet_instances

  name                 = each.value.name
  resource_group_name  = azurerm_resource_group.network[each.value.region].name
  virtual_network_name = azurerm_virtual_network.this[each.value.region].name
  address_prefixes     = [each.value.address_prefix]
}

resource "azurerm_network_security_group" "private" {
  for_each = local.regions

  name                = "${var.name_prefix}-${each.key}-nsg-private-01"
  location            = each.value.location
  resource_group_name = azurerm_resource_group.network[each.key].name
  tags                = var.common_tags
}

resource "azurerm_network_security_group" "public" {
  for_each = local.regions

  name                = "${var.name_prefix}-${each.key}-nsg-public-01"
  location            = each.value.location
  resource_group_name = azurerm_resource_group.network[each.key].name
  tags                = var.common_tags
}

resource "azurerm_subnet_network_security_group_association" "private" {
  for_each = {
    for key, subnet in local.subnet_instances : key => subnet
    if subnet.subnet_key == "priv_az1" || subnet.subnet_key == "priv_az2"
  }

  subnet_id                 = azurerm_subnet.this[each.key].id
  network_security_group_id = azurerm_network_security_group.private[each.value.region].id
}

resource "azurerm_subnet_network_security_group_association" "public" {
  for_each = {
    for key, subnet in local.subnet_instances : key => subnet
    if subnet.subnet_key == "pub_az1" || subnet.subnet_key == "pub_az2"
  }

  subnet_id                 = azurerm_subnet.this[each.key].id
  network_security_group_id = azurerm_network_security_group.public[each.value.region].id
}