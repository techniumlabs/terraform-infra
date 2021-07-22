provider "azurerm" {
features {}
}

data "azurerm_resource_group" "rg" {
  count = length(var.exist_resource_group_name) > 0 ? 1 : 0
  name = var.exist_resource_group_name
} 

resource "azurerm_resource_group" "rg" {
  count    = length(var.new_resource_group_name) > 0 ? 1 : 0
  name     = var.new_resource_group_name 
  location = var.location
}

locals {
  resource_group = length(azurerm_resource_group.rg) > 0 ? azurerm_resource_group.rg[0] : data.azurerm_resource_group.rg[0]
}




data "azurerm_storage_account" "sa" {
  count               = length(var.exist_storage_ac_name) > 0 ? 1 : 0
  name                = var.exist_storage_ac_name
  resource_group_name = local.resource_group.name
} 

resource "azurerm_storage_account" "sa" {
  count                    = length(var.new_storage_ac_name) > 0 ? 1 : 0 
  name                     = var.new_storage_ac_name
  resource_group_name      = local.resource_group.name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

locals {
  storage_account = length(azurerm_storage_account.sa) > 0 ? azurerm_storage_account.sa[0] : data.azurerm_storage_account.sa[0]
}




resource "azurerm_sql_server" "server" {
  name                         = var.server_name
  resource_group_name          = local.resource_group.name
  location                     = local.resource_group.location
  version                      = var.server_version
  administrator_login          = var.username
  administrator_login_password = var.password

  extended_auditing_policy {
    storage_endpoint                        = local.storage_account.primary_blob_endpoint
    storage_account_access_key              = local.storage_account.primary_access_key
    storage_account_access_key_is_secondary = true
    retention_in_days                       = 6
  }

  tags = {
    environment = "production"
  }
}

resource "azurerm_sql_firewall_rule" "fr" {
  count               = length(var.firewall_rule)
  name                = var.firewall_rule[count.index].name
  server_name         = azurerm_sql_server.server.name
  resource_group_name = local.resource_group.name
  start_ip_address    = var.firewall_rule[count.index].start_ip_address
  end_ip_address      = var.firewall_rule[count.index].end_ip_address
}

resource "azurerm_sql_database" "db" {
  name                = var.database_name
  resource_group_name = local.resource_group.name
  location            = var.location
  server_name         = azurerm_sql_server.server.name

  extended_auditing_policy {
    storage_endpoint                        = local.storage_account.primary_blob_endpoint
    storage_account_access_key              = local.storage_account.primary_access_key
    storage_account_access_key_is_secondary = true
    retention_in_days                       = 6
  }



  tags = {
    environment = "production"
  }
}

resource "azurerm_sql_elasticpool" "example" {
  name                = var.elasticpool_name
  resource_group_name = local.resource_group.name
  location            = local.resource_group.location
  server_name         = azurerm_sql_server.server.name
  edition             = var.elasticpool_edition
  dtu                 = var.dtu
  db_dtu_min          = var.db_dtu_min
  db_dtu_max          = var.db_dtu_max
  pool_size           = var.pool_size
}