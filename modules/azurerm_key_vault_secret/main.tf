# resource "azurerm_key_vault_secret" "key_secret" {
#   name         = "anupamsecret"
#   value        = "mypass@123"
#   key_vault_id = data.azurerm_key_vault.kv_data.id
# }

# resource "azurerm_key_vault_secret" "key_password" {
#   name         = "anupamsecret1"
#   value        = "mypass@1234"
#   key_vault_id = data.azurerm_key_vault.kv_data.id
# }

resource "azurerm_key_vault_secret" "secret" {
  name         = var.secret_name
  value        = var.secret_value
  key_vault_id = data.azurerm_key_vault.kv_data.id
}
# resource "azurerm_key_vault_secret" "secret1" {
#   name         = var.secret_name1
#   value        = var.secret_value1
#   key_vault_id = data.azurerm_key_vault.kv_data.id
# }



