resource "azurerm_resource_group" "network" {
  name     = var.network_rg_name
  location = var.location
  tags     = var.tags
}

resource "azurerm_resource_group" "linux" {
  name     = var.linux_rg_name
  location = var.location
  tags     = var.tags
}

resource "azurerm_resource_group" "windows" {
  name     = var.windows_rg_name
  location = var.location
  tags     = var.tags
}
