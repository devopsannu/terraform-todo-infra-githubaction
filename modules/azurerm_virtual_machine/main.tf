resource "azurerm_linux_virtual_machine" "virtual_machine" {
  name                  = var.vm_name
  resource_group_name   = var.rg_name
  location              = var.rg_location
  size                  = "Standard_F2"
  admin_username        = var.admin_username
  admin_password        = var.admin_password
  network_interface_ids = [var.nic_id]

  disable_password_authentication = false



  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}

#    provisioner "remote-exec" {
#     inline = [
#       "sudo apt-get update",
#       "sudo apt-get install -y nginx git",
#       "git clone https://github.com/devopsinsiders/StreamFlix.git /tmp/streamflix",
#       "sudo cp /tmp/streamflix/index.html /var/www/html/index.html",
#       "sudo systemctl restart nginx"
#     ]
#   }

#   connection {
#     type     = "ssh"
#     user     = "nupamsecret"
#     password = "mypass@123"
#     host     = azurerm_network_interface.nic.private_ip_address
#     timeout  = "5m"
#   }
# }
# output "vm_private_ip" {
#   value = azurerm_network_interface.nic.private_ip_address
# }


