resource "azurerm_resource_group" "example" {
  name     = "api-rg-pro"
  location = "West Europe"
}
output "dbdns" {
  description = "dns for DB"
  value = azurerm_mysql_database.example.dns_name
}
resource "azurerm_mysql_server" "example" {
  name                = "mysql-server-1"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  sku_name = "GP_Gen5_2"

  storage_profile {
    storage_mb            = 5120
    backup_retention_days = 7
    geo_redundant_backup  = "Disabled"
  }

  administrator_login          = "psqladminun"
  administrator_login_password = "H@Sh1CoR3!"
  version                      = "5.7"
  ssl_enforcement              = "Enabled"
}

resource "azurerm_mysql_configuration" "example" {
  name                = "interactive_timeout"
  resource_group_name = azurerm_resource_group.example.name
  server_name         = azurerm_mysql_server.example.name
  value               = "600"
}

resource "azurerm_mysql_database" "example" {
  name                = "exampledb"
  resource_group_name = azurerm_resource_group.example.name
  server_name         = azurerm_mysql_server.example.name
  charset             = "utf8"
  collation           = "utf8_unicode_ci"
}
resource "azurerm_mysql_firewall_rule" "example" {
  name                = "office"
  resource_group_name = azurerm_resource_group.example.name
  server_name         = azurerm_mysql_server.example.name
  start_ip_address    = "10.0.0.4"
  end_ip_address      = "10.0.0.255"
}

