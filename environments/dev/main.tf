locals {
  common_tags = {
    environment = "dev"
    owner       = "Todoappteam"
    managed-by  = "Terraform"
  }
}

module "rg" {
  source      = "../../modules/azurerm_resource_group"
  rg_name     = "express_rg"
  rg_location = "East US"
  rg_tags     = local.common_tags
}

# module "acr" {
#   source   = "../../modules/azurerm_container_registry"
#   acr_name = "acrdevtodoapp"
#   rg_name  = "rg-dev-todoapp"
#   location = "East US"
#   tags     = local.common_tags

# }
# module "sql_server" {
#   source          = "../../modules/azurerm_sql_server"
#   sql_server_name = "sqlserver-dev-todoapp"
#   rg_name         = "rg-dev-todoapp"
#   location        = "East US"
#   admin_username  = "devopsadmin"
#   admin_password  = "India@123india@123"
#   tags            = local.common_tags
# }

# module "sql_db" {
#   source      = "../../modules/azurerm_sql_database"
#   sql_db_name = "sqldb-dev-todoapp"
#   server_id   = module.sql_server.server_id

#   max_size_gb = "2"
#   tags       = local.common_tags

# }
# module "aks" {
#   source     = "../../modules/azurerm_kubernetes_cluster"
#   aks_name   = "aks-dev-todoapp"
#   location   = "East US"
#   rg_name    = "rg-dev-todoapp"
#   dns_prefix = "aks-dev-todoapp"

#   tags = local.common_tags

# }
module "storage_account" {
  depends_on  = [module.rg]
  source      = "../../modules/azurerm_storage_account"
  sa_name     = "expresssatodoapp"
  rg_name     = "express_rg"
  rg_location = "East US"
  sa_tags     = local.common_tags
}

module "vnet" {
  depends_on         = [module.rg]
  source             = "../../modules/azurerm_virtual_network"
  vnet_name          = "express_vnet"
  vnet_address_space = ["10.0.0.0/16"]
  rg_name            = "express_rg"
  rg_location        = "East US"
  rg_tags            = local.common_tags

}

module "subnet" {
  depends_on            = [module.vnet]
  source                = "../../modules/azurerm_subnet"
  subnet_name           = "express_subnet"
  vnet_name             = "express_vnet"
  rg_name               = "express_rg"
  subnet_address_prefix = ["10.0.1.0/24"]
}
module "subnet1" {
  depends_on            = [module.vnet]
  source                = "../../modules/azurerm_subnet"
  subnet_name           = "express_subnet1"
  vnet_name             = "express_vnet"
  rg_name               = "express_rg"
  subnet_address_prefix = ["10.0.3.0/24"]
}

module "bastion_subnet" {
  depends_on            = [module.vnet]
  source                = "../../modules/azurerm_subnet"
  subnet_name           = "AzureBastionSubnet"
  vnet_name             = "express_vnet"
  rg_name               = "express_rg"
  subnet_address_prefix = ["10.0.2.0/26"]
}

module "pip_lb" {
  depends_on  = [module.rg]
  source      = "../../modules/azurerm_public_ip"
  pip_name    = "express_pip_lb"
  rg_name     = "express_rg"
  rg_location = "East US"
  rg_tags     = local.common_tags
}

module "pip_bastion" {
  depends_on  = [module.rg]
  source      = "../../modules/azurerm_public_ip"
  pip_name    = "express_pip_bastion"
  rg_name     = "express_rg"
  rg_location = "East US"
  rg_tags     = local.common_tags
}

module "nic" {
  depends_on  = [module.rg, module.subnet]
  source      = "../../modules/azurerm_network_interface"
  nic_name    = "express_nic"
  rg_name     = "express_rg"
  rg_location = "East US"
  subnet_id   = data.azurerm_subnet.data_subnet.id
}
module "nic2" {
  depends_on  = [module.rg, module.subnet1]
  source      = "../../modules/azurerm_network_interface"
  nic_name    = "express_nic1"
  rg_name     = "express_rg"
  rg_location = "East US"
  subnet_id   = data.azurerm_subnet.data_subnet1.id
}

module "vm" {
  depends_on     = [module.rg, module.nic, module.key_vault, module.secret_name, module.secret_password]
  source         = "../../modules/azurerm_virtual_machine"
  vm_name        = "expressvm"
  rg_name        = "express_rg"
  rg_location    = "East US"
  admin_username = data.azurerm_key_vault_secret.data_secret.value
  admin_password = data.azurerm_key_vault_secret.data_password.value
  nic_id         = data.azurerm_network_interface.data_nic.id
}

module "vm1" {
  depends_on     = [module.rg, module.nic, module.key_vault, module.secret_name1, module.secret_password]
  source         = "../../modules/azurerm_virtual_machine"
  vm_name        = "expressvm1"
  rg_name        = "express_rg"
  rg_location    = "East US"
  admin_username = data.azurerm_key_vault_secret.data_secret1.value
  admin_password = data.azurerm_key_vault_secret.data_password1.value
  nic_id         = data.azurerm_network_interface.data_nic1.id
}

module "key_vault" {
  depends_on  = [module.rg]
  source      = "../../modules/azurerm_key_vault"
  kv_name     = "expresskv1234"
  rg_name     = "express_rg"
  rg_location = "East US"
  tags        = local.common_tags
}




module "secret_name" {
  depends_on   = [module.key_vault, module.rg]
  source       = "../../modules/azurerm_key_vault_secret"
  kv_name      = "expresskv1234"
  rg_name      = "express_rg"
  secret_name  = "anupamsecret"
  secret_value = "mypass@123"
}

module "secret_password" {
  depends_on   = [module.key_vault, module.secret_name]
  source       = "../../modules/azurerm_key_vault_secret"
  kv_name      = "expresskv1234"
  rg_name      = "express_rg"
  secret_name  = "mypass-123"
  secret_value = "mypass@123"
}
module "secret_name1" {
  depends_on   = [module.key_vault]
  source       = "../../modules/azurerm_key_vault_secret"
  kv_name      = "expresskv1234"
  rg_name      = "express_rg"
  secret_name  = "anupamsecret1"
  secret_value = "mypass@123"
}

module "secret_password1" {
  depends_on   = [module.key_vault, module.secret_name1]
  source       = "../../modules/azurerm_key_vault_secret"
  kv_name      = "expresskv1234"
  rg_name      = "express_rg"
  secret_name  = "mypass-1234"
  secret_value = "mypass@123"
}

module "load_balancer" {
  depends_on       = [module.rg, module.subnet]
  source           = "../../modules/azurerm_loadbalancer"
  lb_name          = "express_lb"
  location         = "East US"
  rg_name          = "express_rg"
  frontend_ip_name = "PublicIPAddress"
}

module "bastion" {
  depends_on   = [module.rg, module.bastion_subnet, module.pip_bastion]
  source       = "../../modules/azurerm_bastion"
  bastion_name = "AzureBastionSubnet"
  rg_name      = "express_rg"
  rg_location  = "East US"
}
