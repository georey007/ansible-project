
provider "azurerm" {
  features {}
  subscription_id = "37accd0d-e5be-4b04-8322-06efcb21cc4e"
}
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.19"
    }
  }
  required_version = "~> 1.9"
}
