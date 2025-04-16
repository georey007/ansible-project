resource "azurerm_public_ip" "windows_pip" {
  for_each            = var.windows_vms
  name                = "pip-${each.key}"
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = "Static"

  # Assign a DNS name for each VM based on its key
  domain_name_label   = lower("${each.key}")  # Generates a unique Azure DNS name
}

resource "azurerm_network_interface" "windows_nic" {
  for_each            = var.windows_vms
  name                = "nic-${each.key}"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "ipconfig-${each.key}"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.windows_pip[each.key].id
  }
}

resource "azurerm_windows_virtual_machine" "windows_vm" {
  for_each            = var.windows_vms
  name                = each.key
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = each.value
  admin_username      = var.admin_username
  computer_name       = each.key
  admin_password      = var.admin_password

  network_interface_ids = [
    azurerm_network_interface.windows_nic[each.key].id
  ]

  os_disk {
    name                 = "windows_os-disk-${each.key}"
    caching              = var.windows_os_disk.caching
    storage_account_type = var.windows_os_disk.storage_account_type
    #disk_size_gb         = var.windows_os_disk.disk_size_gb
  }

  source_image_reference {
    publisher = var.windows_os_info.publisher
    offer     = var.windows_os_info.offer
    sku       = var.windows_os_info.sku
    version   = var.windows_os_info.version
  }

  winrm_listener {
    protocol = "Http"
  }
}

resource "azurerm_availability_set" "windows_vm_avs" {
  name                = var.windows_avs
  resource_group_name = var.resource_group_name
  location            = var.location

  platform_fault_domain_count  = 2
  platform_update_domain_count = 5
}
