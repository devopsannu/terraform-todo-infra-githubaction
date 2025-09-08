data "azurerm_subnet" "data_subnet" {
  name                    = "express_subnet"
  virtual_network_name    = "express_vnet"
  resource_group_name     = "express_rg"
  depends_on = [ module.subnet ]
}

data "azurerm_subnet" "data_subnet1" {
  name                    = "express_subnet1"
  virtual_network_name    = "express_vnet"
  resource_group_name     = "express_rg"
  depends_on = [ module.subnet1 ]
}


data "azurerm_network_interface" "data_nic" {
  name                = "express_nic"
  resource_group_name = "express_rg"
  depends_on = [ module.nic ]
}
data "azurerm_network_interface" "data_nic1" {
  name                = "express_nic1"
  resource_group_name = "express_rg"
  depends_on = [ module.nic2 ]
}

data "azurerm_key_vault" "kv_data" {
  name                = "expresskv1234"
  resource_group_name = "express_rg"
  depends_on = [ module.key_vault ]
}


data "azurerm_key_vault_secret" "data_secret" {
  name         = "anupamsecret"
  key_vault_id = data.azurerm_key_vault.kv_data.id
  depends_on = [ module.secret_name, module.key_vault ]
}
data "azurerm_key_vault_secret" "data_password" {
  name         = "mypass-123"
  key_vault_id = data.azurerm_key_vault.kv_data.id
  depends_on = [ module.secret_name, module.secret_password, module.key_vault ]
}

data "azurerm_key_vault_secret" "data_secret1" {
  name         = "anupamsecret1"
  key_vault_id = data.azurerm_key_vault.kv_data.id
  depends_on = [ module.secret_name, module.secret_name1, module.key_vault ]
}

data "azurerm_key_vault_secret" "data_password1" {
  name         = "mypass-1234"
  key_vault_id = data.azurerm_key_vault.kv_data.id
  depends_on = [ module.secret_name, module.secret_password1, module.key_vault ]
}

data "azurerm_key_vault_secret" "sql_data_secret" {
  name         = "sqlanupam"
  key_vault_id = data.azurerm_key_vault.kv_data.id
  depends_on = [ module.secret_name, module.secret_name1, module.secret_password1, module.secret_password, module.key_vault, module.sql_secret_username, module.sql_secret_password  ]
}

data "azurerm_key_vault_secret" "sql_data_password" {
  name         = "mypass-12345"
  key_vault_id = data.azurerm_key_vault.kv_data.id
  depends_on = [ module.sql_secret_password, module.sql_secret_username, module.secret_name, module.secret_password1, module.key_vault , module.sql_secret_username ]
}

 
