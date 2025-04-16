output "rg_network_name" {
  value = azurerm_resource_group.network.name
}

output "rg_linux_name" {
  value = azurerm_resource_group.linux.name
}

output "rg_windows_name" {
  value = azurerm_resource_group.windows.name
}

output "location" {
  value = azurerm_resource_group.network.location
}
