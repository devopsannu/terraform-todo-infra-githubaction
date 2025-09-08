data "azurerm_network_interface" "data_nic" {
  name                = var.nic_name
  resource_group_name = var.rg_name
}
data "azurerm_network_security_group" "data_nsg" {
  name                = var.nsg_name
  resource_group_name = var.rg_name
}
