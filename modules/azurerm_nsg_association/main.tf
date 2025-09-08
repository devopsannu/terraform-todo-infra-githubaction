resource "azurerm_network_interface_security_group_association" "nsg_association" {
  network_interface_id      = data.azurerm_network_interface.data_nic.id
  network_security_group_id = data.azurerm_network_security_group.data_nsg.id
}