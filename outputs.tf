

//resource_group

output "network_rg" {
  value = module.resource_group.rg_network_name
}

output "linux_rg" {
  value = module.resource_group.rg_linux_name
}

output "windows_rg" {
  value = module.resource_group.rg_windows_name
}

//network

output "vnet_name" {
  value = module.network.vnet_name
}

output "vnet_address_space" {
  value = module.network.vnet_address_space[0]
}

output "subnet1_name" {
  value = module.network.subnet1_name
}

output "subnet2_name" {
  value = module.network.subnet2_name
}
output "nsg1_name" {
  value = module.network.nsg1_name
}

output "nsg2_name" {
  value = module.network.nsg2_name
}

//linux

output "linux_vm_names" {
  value = module.linux_vms.linux_vm_names
}

output "linux_vm_hostnames" {
  value = module.linux_vms.linux_vm_names
}

output "linux_vm_fqdns" {
  value = [for i in range(length(module.linux_vms.linux_vm_public_ips)) :
    "${module.linux_vms.linux_vm_names[i]}.${module.resource_group.location}.cloudapp.azure.com"
  ]
}

output "linux_vm_private_ips" {
  value = module.linux_vms.linux_vm_private_ips
}

output "linux_vm_public_ips" {
  value = module.linux_vms.linux_vm_public_ips
}

output "linux_availability_set" {
  value = module.linux_vms.linux_availability_set
}

// Windows

output "windows_vm_names" {
  value = module.windows_vms.windows_vm_names
}

output "windows_vm_private_ips" {
  value = module.windows_vms.windows_vm_private_ips
}

output "windows_vm_public_ips" {
  value = module.windows_vms.windows_vm_public_ips
}

output "windows_availability_set" {
  value = module.windows_vms.windows_availability_set
}
