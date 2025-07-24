# Ajout d'une data source pour referencer le groupe de ressources existants
data "azurerm_resource_group" "existing" {
  name = var.resource_group_name
}

resource "azurerm_app_service_plan" "plan" {
  name = "${var.app_name}-plan"
  location = data.azurerm_resoure_group.existing.location
  resource_group_name = data.azurerm_resource_group.existing.name
  kind = "Linux"
  reserved = true

  sku {
    tier = "Free"
    size = "F1"
  }
}

resource "azurerm_app_service" "app" {
  name = var.app_name
  location = data.azurerm_resource_group.existing.location
  resource_group_name = data.azurerm_resource_group.existing.name
  app_service_plan_id = azurerm_app_service_plan.plan.id
  
  site_config {
    linux_fx_version = "NODE|18-lts"
  }

  app_settings = {
    WEBSITE_RUN_FROM_PACKAGE = "1"
  }
}