resource "azurerm_container_registry" "acr" {
  name                = var.arc_name  # Debe ser único a nivel global
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku                 = "Basic" 
  admin_enabled       = true      # Habilitar acceso administrativo
}

# resource "local_file" "ansible_inventory" {
#   depends_on = [azurerm_linux_virtual_machine.podman_vm]

#     content = templatefile("inventory.tmpl",{
#       podman_vm_ip = data.azurerm_public_ip.ip_address
#       acr_username = azurerm_container_registry.acr.admin_username
#     })
#     filename = "inventory"
# }

# resource "local_file" "ansible_inventory" {
#   depends_on = [azurerm_linux_virtual_machine.podman_vm]

#   content = templatefile("inventory.tmpl", {
#     podman_vm_ip   = data.azurerm_public_ip.ip_address
#     acr_username    = azurerm_container_registry.acr.admin_username
#     acr_password    = azurerm_container_registry.acr.admin_password  # Asegúrate de que esta variable esté definida
#     ssh_key_path    = "../.ssh/vm_key"  # Ruta a la clave privada
#     rootuser        = var.podman_vm_username
#   })
#   filename = "inventory"
# }