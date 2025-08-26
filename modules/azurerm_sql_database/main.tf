resource "azurerm_mssql_database" "sql_db" {
  name         = var.sql_db_name
  server_id    = var.server_id
  collation    = "SQL_Latin1_General_CP1_CI_AS"
  max_size_gb  = var.max_size_gb
  sku_name     = "S0"
  license_type = "LicenseIncluded"
  enclave_type = "VBS"
  tags         = var.tags
}


