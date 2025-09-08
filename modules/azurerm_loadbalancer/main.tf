resource "azurerm_lb" "load_balancer" {
  name                = var.lb_name
  location            = var.location
  resource_group_name = var.rg_name

  frontend_ip_configuration {
    name                 = var.frontend_ip_name
    public_ip_address_id = data.azurerm_public_ip.pip_data.id
  }
}

resource "azurerm_lb_backend_address_pool" "pool" {
  loadbalancer_id = azurerm_lb.load_balancer.id
  name            = "backendpool"
}

resource "azurerm_lb_probe" "lb_probe" {
loadbalancer_id = azurerm_lb.load_balancer.id
name = "nginx-probe"
port = 80
}

resource "azurerm_lb_rule" "lb_rule" {
name = "lb_rule"
loadbalancer_id = azurerm_lb.load_balancer.id
protocol = "Tcp"
frontend_port = 80
backend_port = 80
frontend_ip_configuration_name = "PublicIPAddress"
backend_address_pool_ids = [azurerm_lb_backend_address_pool.pool.id]
probe_id = azurerm_lb_probe.lb_probe.id
}


