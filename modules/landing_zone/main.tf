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

resource "azurerm_log_analytics_workspace" "platform" {
  name                = "${var.env}-${var.workload_name}-law-${var.region_token}"
  location            = azurerm_resource_group.platform.location
  resource_group_name = azurerm_resource_group.platform.name
  sku                 = var.log_analytics_sku
  retention_in_days   = 30
  tags                = var.common_tags
}

output "resource_group_name" {
  description = "Platform resource group name."
  value       = azurerm_resource_group.platform.name
}

output "log_analytics_workspace_id" {
  description = "Log Analytics workspace ID for operational monitoring."
  value       = azurerm_log_analytics_workspace.platform.id
}

output "management_group_name" {
  description = "Management group name associated with the landing zone."
  value       = var.management_group_id
}

output "subscription_name" {
  description = "Subscription name associated with this landing zone."
  value       = var.subscription_name
}
