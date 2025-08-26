locals {
  common_tags = {
    environment = "dev"
    owner       = "Todoappteam"
    managed-by  = "Terraform"
  }
}


module "rg" {
  source      = "../../modules/azurerm_resource_group"
  rg_name    = "rg-dev-todoapp"
  rg_location = "East US"
  rg_tags    = local.common_tags
}

module "acr" {
  source   = "../../modules/azurerm_container_registry"
  acr_name = "acrdevtodoapp"
  rg_name  = "rg-dev-todoapp"
  location = "East US"
  tags     = local.common_tags

}
module "sql_server" {
  source          = "../../modules/azurerm_sql_server"
  sql_server_name = "sqlserver-dev-todoapp"
  rg_name         = "rg-dev-todoapp"
  location        = "East US"
  admin_username  = "devopsadmin"
  admin_password  = "India@123india@123"
  tags            = local.common_tags
}

module "sql_db" {
  source      = "../../modules/azurerm_sql_database"
  sql_db_name = "sqldb-dev-todoapp"
  server_id   = module.sql_server.server_id

  max_size_gb = "2"
  tags       = local.common_tags

}
module "aks" {
  source     = "../../modules/azurerm_kubernetes_cluster"
  aks_name   = "aks-dev-todoapp"
  location   = "East US"
  rg_name    = "rg-dev-todoapp"
  dns_prefix = "aks-dev-todoapp"

  tags = local.common_tags

}
