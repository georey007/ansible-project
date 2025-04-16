resource "azurerm_public_ip" "linux_pip" {
  count               = var.nb_count
  name                = "${var.linux_name}-pip-${format("%d", count.index + 1)}"
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = "Static"
  domain_name_label   = "n01709202-c-vm${count.index + 1}"
}

resource "azurerm_network_interface" "linux_nic" {
  count               = var.nb_count
  name                = "${var.linux_name}-nic-${format("%d", count.index + 1)}"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "${var.linux_name}-ipconfig-${format("%d", count.index + 1)}"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.linux_pip[count.index].id
  }
}

resource "azurerm_network_security_group" "linux_nsg" {
  name                = "${var.linux_name}-nsg"
  location            = var.location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_interface_security_group_association" "linux_nic_nsg_assoc" {
  count                     = var.nb_count
  network_interface_id      = azurerm_network_interface.linux_nic[count.index].id
  network_security_group_id = azurerm_network_security_group.linux_nsg.id
}

resource "azurerm_availability_set" "linux_vm_avs" {
  name                         = var.linux_avs
  resource_group_name          = var.resource_group_name
  location                     = var.location
  platform_fault_domain_count  = 2
  platform_update_domain_count = 5
}

resource "azurerm_linux_virtual_machine" "linux_vm" {
  count               = var.nb_count
  name                = "${var.linux_name}${format("%d", count.index + 1)}"
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = "Standard_B1s"
  admin_username      = var.admin_username

  network_interface_ids = [
    azurerm_network_interface.linux_nic[count.index].id
  ]

  admin_ssh_key {
    username   = "azureuser"
    public_key = file("/home/n01709202/georgey/id_rsa.pub")
  }

  os_disk {
    name                 = "${var.linux_name}-os-disk-${format("%d", count.index + 1)}"
    caching              = var.os_disk.caching
    storage_account_type = var.os_disk.storage_account_type
    disk_size_gb         = var.os_disk.disk_size_gb
  }

  source_image_reference {
    publisher = "OpenLogic"
    offer     = "CentOS"
    sku       = "8_2"
    version   = "latest"
  }

  disable_password_authentication = true
}

resource "azurerm_managed_disk" "linux_data_disk" {
  count                = var.nb_count
  name                 = "${var.linux_name}-datadisk-${format("%d", count.index + 1)}"
  location             = var.location
  resource_group_name  = var.resource_group_name
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = 10
}

resource "azurerm_virtual_machine_data_disk_attachment" "linux_data_disk_attach" {
  count                = var.nb_count
  managed_disk_id      = azurerm_managed_disk.linux_data_disk[count.index].id
  virtual_machine_id   = azurerm_linux_virtual_machine.linux_vm[count.index].id
  lun                  = 0
  caching              = "ReadWrite"
}
