terraform {
  required_version = ">= 1.10.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "bw-prod-eus-infra-rg-01"
    storage_account_name = "bwprodeusinfrasttfst01"
    container_name       = "tfstate-prod"
    key                  = "platform/terraform.tfstate"
    use_azuread_auth     = true
    use_oidc             = true
  }
}
