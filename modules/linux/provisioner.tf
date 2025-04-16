
resource "null_resource" "linux_provisioner" {
  count = var.nb_count

  connection {
    type        = "ssh"
    user        = var.admin_username
    private_key = file(var.private_key)
    host        = azurerm_linux_virtual_machine.linux_vm[count.index].public_ip_address
  }

  provisioner "remote-exec" {
  inline = [
    "sudo setenforce 0",
    "sudo yum install -y nginx",
    "sudo systemctl enable nginx",
    "sudo systemctl start nginx",
    "sudo setenforce 1"
  ]
 }

}
