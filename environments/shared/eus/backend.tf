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

  backend "azurerm" {
    resource_group_name  = "bw-shared-eus-infra-rg-01"
    storage_account_name = "bwsharedeusinfrasttfst01"
    container_name       = "tfstate-shared"
    key                  = "platform/terraform.tfstate"
    use_azuread_auth     = true
    use_oidc             = true
  }
}
