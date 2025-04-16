
locals {
  common_tags = {
    Project        = "CCGC 5502 Automation Project"
    Name           = "georgey.siby"
    ExpirationDate = "2025-04-14"
    Environment    = "Project"
  }
}



// Module call for the resource group module
module "resource_group" {
  source          = "./modules/resource_group"
  location        = "canadacentral"
  network_rg_name = "rg-network"
  linux_rg_name   = "rg-linux"
  windows_rg_name = "rg-windows"
  tags            = local.common_tags
}

// Module call for the network module
module "network" {
  source                = "./modules/network"
  resource_group_name   = module.resource_group.rg_network_name
  location              = module.resource_group.location
  vnet                  = "vnet"
  vnet_address_space    = ["10.0.0.0/16"]
  subnet1               = "network_subnet1"
  subnet1_address_space = ["10.0.1.0/24"]
  subnet2               = "network_subnet2"
  subnet2_address_space = ["10.0.2.0/24"]
  nsg1                  = "nsg1"
  nsg2                  = "nsg2"
  tags                  = local.common_tags
}


module "linux_vms" {
  source              = "./modules/linux"
  resource_group_name = module.resource_group.rg_linux_name
  location            = module.resource_group.location
  nb_count            = 2
  linux_name          = "n01709201-c-vm"
  subnet_id           = module.network.subnet1_id
  admin_username      = "azureuser"
  public_key          = "/home/n01709202/georgey/id_rsa.pub"
  private_key         = "/home/n01709202/georgey/id_rsa"
  tags                = local.common_tags

  linux_avs = "linux-avs"

  os_disk = {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    disk_size_gb         = 30
  }

  os_info = {
    publisher = "OpenLogic"
    offer     = "CentOS"
    sku       = "8_2"
    version   = "latest"
  }
}

module "windows_vms" {
  source              = "./modules/windows"
  resource_group_name = module.resource_group.rg_windows_name
  location            = module.resource_group.location
  subnet_id           = module.network.subnet2_id
  admin_username      = "azureadmin"
  admin_password      = "Georgey@12345"
  tags                = local.common_tags

  windows_vms = {
    "n01709201-w-vm1" = "Standard_B1s"
  }

  windows_avs = "windows-avs"

  windows_os_disk = {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    disk_size_gb         = 50
  }

  windows_os_info = {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }

   windows_dns_labels = {
    "n01709201-w-vm1" = "n01709201-w-vm1"
  }
}
