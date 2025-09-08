resource "azurerm_network_interface_backend_address_pool_association" "nlb_association" {
  network_interface_id    = data.azurerm_network_interface.data_nic.id
  ip_configuration_name   = var.ip_configuration_name
  backend_address_pool_id = data.azurerm_lb_backend_address_pool.data_lb_pool.id
}

data "azurerm_network_interface" "data_nic" {
  name                = var.nic_name
  resource_group_name = var.rg_name
}

data "azurerm_lb_backend_address_pool" "data_lb_pool" {
  name                = var.lb_pool_name
  loadbalancer_id    = data.azurerm_lb.data_lb.id
}

data "azurerm_lb" "data_lb" {
  name                = var.lb_name
  resource_group_name = var.rg_name
}

