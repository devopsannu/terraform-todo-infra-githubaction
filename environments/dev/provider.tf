terraform {
                required_version = ">=1.10.0"
  # backend "azurerm" {
  #   resource_group_name  = "rg-anupam"
  #   storage_account_name = "stgannu2112"
  #   container_name       = "stgannu2112"
  #   key                  = "dev.terraform.tfstate"

  # }
  required_providers {
   
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.43.0"
    }
  }
}

provider "azurerm" {


  features {}
  subscription_id = "239f86cf-d0d2-4954-935f-40e39253100c"
}

