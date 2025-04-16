resource "azurerm_virtual_network" "network_vnet" {
  name                = var.vnet
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = var.vnet_address_space
}

resource "azurerm_subnet" "network_subnet1" {
  name                 = var.subnet1
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.network_vnet.name
  address_prefixes     = var.subnet1_address_space
}

resource "azurerm_subnet" "network_subnet2" {
  name                 = var.subnet2
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.network_vnet.name
  address_prefixes     = var.subnet2_address_space
}

resource "azurerm_network_security_group" "network_nsg1" {
  name                = var.nsg1
  location            = var.location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "allow_ssh"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "allow_http"
    priority                   = 200
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_security_group" "network_nsg2" {
  name                = var.nsg2
  location            = var.location
  resource_group_name = var.resource_group_name

  # SSH rule for port 22
  security_rule {
    name                       = "allow_ssh"
    priority                   = 3000
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  # RDP rule for port 3389
  security_rule {
    name                       = "allow_rdp"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  # WinRM rule for port 5985
  security_rule {
    name                       = "allow_winrm"
    priority                   = 200
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "5985"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

# Associate NSGs with Subnets
resource "azurerm_subnet_network_security_group_association" "subnet1_sg_association" {
  subnet_id                 = azurerm_subnet.network_subnet1.id
  network_security_group_id = azurerm_network_security_group.network_nsg1.id
}

resource "azurerm_subnet_network_security_group_association" "subnet2_sg_association" {
  subnet_id                 = azurerm_subnet.network_subnet2.id
  network_security_group_id = azurerm_network_security_group.network_nsg2.id
}
