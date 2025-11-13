# data "azurerm_key_vault" "kv_data" {
#   name                = "expresskv1234"
#   resource_group_name = "express_rg"
# }

data "azurerm_key_vault" "kv_data" {
  name                = var.kv_name
  resource_group_name = var.rg_name
}

