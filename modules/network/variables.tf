variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "vnet" {
  type = string
}

variable "vnet_address_space" {
  type = list(string)
}

variable "dns_servers" {
  type    = list(string)
  default = ["10.0.0.8", "10.0.0.9"]
}

variable "subnet1" {
  type = string
}

variable "subnet1_address_space" {
  type = list(string)
}

variable "subnet2" {
  type = string
}

variable "subnet2_address_space" {
  type = list(string)
}

variable "nsg1" {
  type = string
}

variable "nsg2" {
  type = string
}

variable "tags" {
  type = map(string)
}
