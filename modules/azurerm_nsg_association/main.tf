resource "azurerm_network_interface_application_security_group_association" "example" {
  network_interface_id          = azurerm_network_interface.example.id
  application_security_group_id = azurerm_application_security_group.example.id
}