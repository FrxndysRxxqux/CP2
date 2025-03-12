resource "azurerm_container_registry" "acr" {
  name                = var.arc_name  # Debe ser único a nivel global
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku                 = "Basic" 
  admin_enabled       = true      # Habilitar acceso administrativo
}

