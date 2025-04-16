resource "azurerm_public_ip" "lb_pip" {
  name                = "n01709202-lb-pip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
  domain_name_label   = "n01709202-lb"
}

resource "azurerm_lb" "linux_lb" {
  name                = "n01709202-lb"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Standard"

  frontend_ip_configuration {
    name                 = "public-lb-fe"
    public_ip_address_id = azurerm_public_ip.lb_pip.id
  }
}
