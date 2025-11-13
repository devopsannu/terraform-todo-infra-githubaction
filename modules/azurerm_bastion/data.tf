data "azurerm_public_ip" "bastion_data" {
  name                = "express_pip_bastion"
  resource_group_name = "express_rg"
}

data "azurerm_subnet" "bastion_subnet" {
  name                 = "AzureBastionSubnet"
  virtual_network_name = "express_vnet"
  resource_group_name  = "express_rg"
}