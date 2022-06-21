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