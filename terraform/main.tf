terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      # version = "~> 3.45.0"
      version = "~> 3.90.0"  # Usa una versión más reciente y estable

    }
  }
}

provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}

provider "kubernetes" {
  config_path    = "~/.kube/config" # Ruta por defecto donde se guarda kubeconfig
  config_context = var.aks_name # Nombre del contexto del clúster
}