terraform {
  backend "azurerm" {
    resource_group_name  = "n01709202-tfstate-rg"
    storage_account_name = "tfstaten01709202sa"
    container_name       = "tfstatefiles"
    key                  = "terraform.tfstate"
  }
}
