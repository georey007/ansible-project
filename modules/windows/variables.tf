variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "admin_username" {
  type    = string
  default = "adminuser"
}

variable "admin_password" {
  type = string
}

variable "windows_vms" {
  type        = map(string)
  description = "Map of Windows VM names to sizes"
}

variable "windows_os_disk" {
  type = object({
    caching              = string
    storage_account_type = string
    disk_size_gb         = number
  })
  default = {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    disk_size_gb         = 127
  }
}


variable "windows_os_info" {
  type = object({
    publisher = string
    offer     = string
    sku       = string
    version   = string
  })
}

variable "windows_avs" {
  type = string
}

variable "windows_dns_labels" {
  type    = map(string)
  default = {}
  description = "DNS labels for Windows VMs public IPs"
}


variable "tags" {
  type = map(string)
}
