output "app_url" {
  value = "https://${azurerm_linux_web_app.app.default_site_hostname}"
}