output "windows_vm_names" {
  value = keys(var.windows_vms)
}

output "windows_vm_private_ips" {
  value = { for k, v in azurerm_network_interface.windows_nic : k => v.ip_configuration[0].private_ip_address }
}

output "windows_vm_public_ips" {
  value = { for k, v in azurerm_public_ip.windows_pip : k => v.ip_address }
}

output "windows_availability_set" {
  value = azurerm_availability_set.windows_vm_avs.name
}
