output "app_url" {
  value = "https://${azurerm_linux_web_app.app.host_names[0]}"
  description = "URL de l’application Web Linux déployée"
}