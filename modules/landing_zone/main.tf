terraform {
  required_version = ">= 1.10.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
    time = {
      source  = "hashicorp/time"
      version = "~> 0.12"
    }
  }
}

provider "azurerm" {
  features {}
}

variable "env" {
  type = string
}

variable "region_token" {
  type = string
}

variable "location" {
  type = string
}

variable "proj" {
  type = string
}

variable "subscription_name" {
  type = string
}

variable "management_group_id" {
  type = string
}

variable "tenant_root_group_name" {
  type    = string
  default = "mg-bw"
}

variable "common_tags" {
  type = map(string)
}

module "naming" {
  source = "../naming"

  env             = var.env
  region_token    = var.region_token
  proj            = var.proj
  resource_type   = "rg"
  qualifier       = "platform"
  instance_number = 1
}

resource "azurerm_resource_group" "platform" {
  name     = module.naming.resource_name
  location = var.location
  tags     = var.common_tags
}

resource "azurerm_management_group" "tenant" {
  name = var.tenant_root_group_name

  lifecycle {
    ignore_changes = [display_name]
  }
}

resource "azurerm_management_group" "child" {
  name                       = var.management_group_id
  display_name               = var.management_group_id
  parent_management_group_id = azurerm_management_group.tenant.id
}

output "resource_group_name" {
  value = azurerm_resource_group.platform.name
}

output "management_group_name" {
  value = azurerm_management_group.child.name
}
