output "vnet_name" {
  value = azurerm_virtual_network.network_vnet.name
}

output "vnet_address_space" {
  value = tolist(azurerm_virtual_network.network_vnet.address_space)
}

output "subnet1_name" {
  value = azurerm_subnet.network_subnet1.name
}

output "subnet2_name" {
  value = azurerm_subnet.network_subnet2.name
}

output "nsg1_name" {
  value = azurerm_network_security_group.network_nsg1.name
}

output "nsg2_name" {
  value = azurerm_network_security_group.network_nsg2.name
}

output "subnet1_id" {
  value = azurerm_subnet.network_subnet1.id
}

output "subnet2_id" {
  value = azurerm_subnet.network_subnet2.id
}
