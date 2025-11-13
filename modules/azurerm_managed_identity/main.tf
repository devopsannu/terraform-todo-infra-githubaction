
resource "azurerm_user_assigned_identity" "ManagedIdentity" {
  name                = var.managed_identity
  location            = var.location
  resource_group_name = var.rg_name

               tags = var.rg_tags
}


