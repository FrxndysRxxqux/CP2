output "rg_id" {
  value = azurerm_resource_group.rg.id
}

output "services_subnet_id" {
  value = azurerm_subnet.services_subnet.id
}

output "main_vnet_id" {
  value = azurerm_virtual_network.main_vnet.id
}

output "acr_username" {
  value = azurerm_container_registry.acr.admin_username
  sensitive = true
}

output "acr_password" {
  value = azurerm_container_registry.acr.admin_password
  sensitive = true
}

output "public_ip" {
  value = azurerm_public_ip.podman_pip.ip_address
}

output "acr_linkio" {
  value = azurerm_container_registry.acr.login_server
}

