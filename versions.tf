terraform {
  required_version = ">= 1.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 4.26"
    }
    azapi = {
      source  = "azure/azapi"
      version = ">= 1.0"
    }
  }
} 
