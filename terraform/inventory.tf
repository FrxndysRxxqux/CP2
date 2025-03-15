# output "acr_username" {
#   value = var.acr_username
# }

# output "acr_password" {
#   value = var.acr_password
# }

resource "local_file" "ansible_inventory" {
  content = templatefile("${path.module}/inventory.tmpl",
    {
      podman_vm_ip              = azurerm_public_ip.podman_pip.ip_address
      rootuser                  = var.podman_vm_username
      ssh_key_path              = "../.ssh/vm_key"
      acr_username              = azurerm_container_registry.acr.admin_username
      acr_password              = azurerm_container_registry.acr.admin_password
      acr_linkio                = azurerm_container_registry.acr.login_server
      dockerhub_global          = "docker.io/frxndysrxxqux"

    }
  )
  filename = "../ansible/inventory.ini"
  #fuerzo dependencia de recursos para poder obtener los valores de estos
  depends_on = [
    azurerm_public_ip.podman_pip,
    azurerm_container_registry.acr
  ]
}


#   podman_vm_ip   = data.azurerm_public_ip.ip_address
#     acr_username    = azurerm_container_registry.acr.admin_username
#     acr_password    = azurerm_container_registry.acr.admin_password  # Asegúrate de que esta variable esté definida
#     ssh_key_path    = "../.ssh/vm_key"  # Ruta a la clave privada
#     rootuser        = var.podman_vm_username