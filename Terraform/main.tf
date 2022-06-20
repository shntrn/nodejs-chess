terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.99.0"
    }
  }
}

provider "azurerm" {
  features {}

}

terraform {
  backend "azurerm" {
    resource_group_name = "tf_rg_blobstore"
    storage_account_name = "tfnodejsstorege"
    container_name = "tfstate"
    key = "terraform.tfstate"
  }
}

data "azurerm_client_config" "current" {
}

resource "azurerm_resource_group" "web-app-recources" {
    name = var.group_name
    location = var.location
    
    tags = merge(var.common_tags, {Type = "Resource Group"})

}

resource "azurerm_cosmosdb_account" "nodejs-chess-db" {
  name = var.db_name
  location = azurerm_resource_group.web-app-recources.location
  resource_group_name = azurerm_resource_group.web-app-recources.name
  offer_type = "Standard"
  kind = "MongoDB"

  tags = merge(var.common_tags, {Type = "Data Base"})

  capabilities {
    name = "MongoDBv3.4"
  }

  capabilities {
    name = "EnableMongo"
  }

  enable_automatic_failover = true

  capabilities {
    name = "EnableAggregationPipeline"
  }

  capabilities {
    name = "mongoEnableDocLevelTTL"
  }

  backup {
    type = "Periodic"
    interval_in_minutes = 1440
    retention_in_hours = 72
    storage_redundancy = "Local"
  }
  consistency_policy {
    consistency_level       = "Session"
  }

  geo_location {
    location = azurerm_resource_group.web-app-recources.location
    failover_priority = 0
  }

}

resource "azurerm_app_service_plan" "backend-plan" {
    name = "${var.backend_name}-plan"
    location = azurerm_resource_group.web-app-recources.location
    resource_group_name = azurerm_resource_group.web-app-recources.name
    kind = "Linux"
    reserved = true
    sku {
      tier = var.backend_tier
      size = var.backend_size
    }

    tags = merge(var.common_tags, {Type = "Service Plan"})
    
}

resource "azurerm_app_service" "nodejs-chess-backend" {
  name = var.backend_name
  location = azurerm_resource_group.web-app-recources.location
  resource_group_name = azurerm_resource_group.web-app-recources.name
  app_service_plan_id = azurerm_app_service_plan.backend-plan.id

  site_config {
    linux_fx_version = var.backend_ver
  }

  tags = merge(var.common_tags, {Type = "WebApp"})
  
  depends_on = [
    azurerm_cosmosdb_account.nodejs-chess-db
    ]
  
  app_settings = {
    PORT = var.backend_port
    DB_URL = azurerm_cosmosdb_account.nodejs-chess-db.connection_strings[0]
  }
 
}

resource "azurerm_storage_account" "nodejschess1" {
  name = var.storage_name
  resource_group_name = azurerm_resource_group.web-app-recources.name
  location = azurerm_resource_group.web-app-recources.location
  account_tier = "Standard"
  account_replication_type = "LRS"

  account_kind = "StorageV2"

  static_website {
    index_document = "index.html"
  }
  
}

output "fe_storage_account_primary_key" {
  value = azurerm_storage_account.nodejschess1.primary_access_key
  sensitive = true
}

output "fe_storage_account_name" {
  value = azurerm_storage_account.nodejschess1.name
  
}

output "api_link" {
  value = azurerm_app_service.nodejs-chess-backend.default_site_hostname   
}