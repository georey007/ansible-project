variable "location" {
  type = string
}

variable "network_rg_name" {
  type = string
}

variable "linux_rg_name" {
  type = string
}

variable "windows_rg_name" {
  type = string
}

variable "tags" {
  type = map(string)
}
