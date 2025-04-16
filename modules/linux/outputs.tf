
output "linux_vm_names" {
  value = azurerm_linux_virtual_machine.linux_vm[*].name
}

output "linux_vm_private_ips" {
  value = azurerm_linux_virtual_machine.linux_vm[*].private_ip_address
}

output "linux_vm_public_ips" {
  value = azurerm_linux_virtual_machine.linux_vm[*].public_ip_address
}

output "linux_availability_set" {
  value = azurerm_availability_set.linux_vm_avs.name
}
