resource "azurerm_role_assignment" "role_acrpull" {
  scope                            = azurerm_container_registry.acr.id
  role_definition_name             = "AcrPull"
  principal_id                     = azurerm_kubernetes_cluster.aks.kubelet_identity.0.object_id
  skip_service_principal_aad_check = true

  depends_on = [azurerm_kubernetes_cluster.aks]

}

resource "azurerm_kubernetes_cluster" "aks" {
  depends_on = [azurerm_container_registry.acr]

  name                = var.aks_name
  # kubernetes_version  = var.kubernetes_version
  kubernetes_version  = "1.29.0"  # Usa una versión estable de AKS
  location            = var.location_name
  # location          = "eastus2"
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = var.aks_name
  
  default_node_pool {
    name                = "system"
    node_count          = 1
    vm_size             = "Standard_B2s"  # 2 vCPUs, 4GB RAM
    type                = "VirtualMachineScaleSets"
    enable_auto_scaling = false
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    load_balancer_sku = "standard"
    network_plugin    = "kubenet" 
  }
}

resource "azurerm_managed_disk" "aks_disk" {
  name                 = "my-aks-disk"
  location             = var.location_name
  resource_group_name  = azurerm_resource_group.rg.name
  storage_account_type = "Standard_LRS"  # Tipo de almacenamiento

  disk_size_gb        = 10  # Tamaño del disco en GB
  create_option       = "Empty"  # Opción de creación del disco
}

#añadiendo rol de lectura para el disco
resource "azurerm_role_assignment" "aks_disk_reader" {
  principal_id   = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id  # Usa el object_id de la identidad asignada
  role_definition_name = "Owner"  # El rol con todos los permisos
  scope          = azurerm_managed_disk.aks_disk.id  # Asegúrate de que esto apunte al disco correcto
  
  depends_on = [azurerm_managed_disk.aks_disk]
}

# Crear un PersistentVolume (PV)
resource "kubernetes_persistent_volume" "pv" {
  depends_on = [azurerm_kubernetes_cluster.aks]  # asegurar que aks esté listo
  metadata {
    name = "my-aks-pv"
  }

  spec {
    capacity = {
      storage = "10Gi"
    }
    access_modes = ["ReadWriteOnce"]

    persistent_volume_source {
      azure_disk {
        caching_mode  = "ReadWrite"
        disk_name     = "my-aks-disk"
        data_disk_uri = azurerm_managed_disk.aks_disk.id 
        kind          = "Managed"
      }
    }
    storage_class_name = "my-storage-class"  
  }
}
#public ip por aks server para los pods
resource "kubernetes_service" "wordpress_service" {
  depends_on = [azurerm_kubernetes_cluster.aks]  # asegurar que aks esté listo
  metadata {
    name = "wordpress-service"
  }

  spec {
    selector = {
      app = "wordpress"
    }

    port {
      port        = 80
      target_port = 80
    }

    type = "LoadBalancer"  # ip para el acceso externo
  }
}

# output "kube_config" {
#   value     = azurerm_kubernetes_cluster.aks.kube_config_raw
#   sensitive = true
# }
