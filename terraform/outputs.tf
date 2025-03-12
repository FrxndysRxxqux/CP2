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

#aks
output "kube_config" {
  value     = azurerm_kubernetes_cluster.aks.kube_config_raw
  sensitive = true
}

output "aks_id" {
  value = azurerm_kubernetes_cluster.aks.id
}

output "aks_fqdn" {
  value = azurerm_kubernetes_cluster.aks.fqdn
}

output "aks_node_rg" {
  value = azurerm_kubernetes_cluster.aks.node_resource_group
}

output "acr_id" {
  value = azurerm_container_registry.acr.id
}

output "aks_loadbalancer_ip"{
  value = kubernetes_service.wordpress_service.status.0.load_balancer.0.ingress.0.ip
}

resource "local_file" "kubeconfig" {
  depends_on   = [azurerm_kubernetes_cluster.aks]
  filename     = "kubeconfig"
  content      = azurerm_kubernetes_cluster.aks.kube_config_raw
}
