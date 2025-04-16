
# Resource Group and Location
variable "resource_group_name" {
  description = "The name of the resource group for the Linux VMs."
  type        = string
}

variable "location" {
  description = "The Azure region where resources will be deployed."
  type        = string
}

# Number of Linux VMs
variable "nb_count" {
  description = "Number of Linux VMs to create."
  type        = number
  default     = 2
}

# Linux VM Name Prefix
variable "linux_name" {
  description = "The base name for Linux VMs."
  type        = string
}

# Linux VM Size
variable "linux_size" {
  description = "The size of the Linux virtual machine."
  type        = string
  default     = "Standard_B1s" # Updated as per your requirement
}

# Networking (Subnet ID)
variable "subnet_id" {
  description = "The subnet ID where the Linux VMs will be deployed."
  type        = string
}

# Administrator Credentials (SSH)
variable "admin_username" {
  description = "The administrator username for the Linux VMs."
  type        = string
  default     = "azureuser"
}

variable "public_key" {
  description = "The path to the SSH public key."
  type        = string
}

variable "private_key" {
  description = "The path to the SSH private key."
  type        = string
}

# Availability Set
variable "linux_avs" {
  description = "The name of the availability set for the Linux VMs."
  type        = string
}

# OS Disk Configuration
variable "os_disk" {
  description = "OS disk settings for the Linux VMs."
  type = object({
    caching              = string
    storage_account_type = string
    disk_size_gb         = number
  })
  default = {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    disk_size_gb         = 30
  }
}

# OS Information (CentOS 8.2)
variable "os_info" {
  description = "The Linux OS version details."
  type = object({
    publisher = string
    offer     = string
    sku       = string
    version   = string
  })
  default = {
    publisher = "OpenLogic"
    offer     = "CentOS"
    sku       = "8_2"
    version   = "latest"
  }
}

variable "tags" {
  type = map(string)
}
