# Ajout d'une data source pour référencer le groupe de ressources existant
data "azurerm_resource_group" "existing" {
  name = var.resource_group_name
}

# ✅ Remplacement de la ressource dépréciée azurerm_app_service_plan par azurerm_service_plan
resource "azurerm_service_plan" "plan" {
  name                = "${var.app_name}-plan"
  location            = data.azurerm_resource_group.existing.location
  resource_group_name = data.azurerm_resource_group.existing.name
  sku_name = "B1"   # <-- obligatoire et unique
  os_type  = "Linux"
}

# ✅ Mise à jour de la référence vers le nouveau service plan
resource "azurerm_linux_web_app" "app" {
  name                = var.app_name
  location            = data.azurerm_resource_group.existing.location
  resource_group_name = data.azurerm_resource_group.existing.name
  service_plan_id     = azurerm_service_plan.plan.id

  site_config {}
}

# 🔗 Lien automatique avec dépôt GitHub (déploiement continu)
data "azurerm_app_service_source_control" "github_link" {
  app_id                  = azurerm_linux_web_app.app.id
  repo_url                = "https://github.com/gervaisalexandre/cvwebstatic"
  branch                  = "main"
  use_manual_integration  = false
  use_mercurial           = false
}
