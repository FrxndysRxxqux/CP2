#basic configuration
variable "resource_group_name" {
  default = "rg-infraestructura"
}
variable "location_name" {
  type        = string
  description = "Región de Azure donde crearemos la infraestructura"
  default     = "westeurope"
}

#network configuration
variable "network_name" {
  default = "main-network"
}

variable "subnet_name" {
  default = "services-subnet"
}

variable "podman_pip_name"{
  description = "Ip publica de podman"
  default ="podman-pip"
}

variable "podman_nic_name"{
  description = "NIC  de podman"
  default ="podman-nic"
}

variable "container_nsg_name" {
  description = "Network security group name"
  default = "container-nsg"
}

#podman vm
variable "podman_vm_name"{
  default ="podman-vm"
}

variable "podman_vm_username"{
  default = "adminuser"
}

#acr 
variable "arc_name"{
  default ="myContainerRegistryfroque"
}


variable "acr_username" {
  description = "Usuario del Azure Container Registry"
  type        = string
  default     = ""  // Se llenará con el output de ACR
}

variable "acr_password" {
  description = "Contraseña del Azure Container Registry"
  type        = string
  default     = ""  // Se llenará con el output de ACR
}

variable "acr_linkio" {
  description = "Link del Azure Container Registry"
  type        = string
  default     = ""  // Se llenará con el output de ACR
}

##AKS
variable "aks_name"{
  default ="myaksclusterfroque"
}

variable "aks_dns_prefix_name"{
  default ="myakscluster"
}

variable "aks_username"{
  description = "User root of aks machine"
  default = "adminuser"

}

variable "owner_object_id"{
  description = "id of owner az user"
  default = "c02debe1-afb8-46a9-b387-d763b580bc20"
}

variable "password_strong"{
  description = "password for aks add group"
  default = "Paswrod@Strong!.#"
}


variable "kubernetes_version" {
  type        = string
  description = "Kubernetes version"
  default=  "1.26.3"
}
variable "system_node_count" {
  type        = number
  description = "Number of AKS worker nodes"
  default = 1
}



# variable "registry_name" {
#   type        = string
#   description = "Nombre del registry de imágenes de contenedor"
#   default     = "ptaritepui"
# }

# variable "registry_sku" {
#   type        = string
#   description = "Tipo de SKU a utilizar por el registry. Opciones válidas: Basic, Standard, Premium."
#   default     = "Basic"
# }


# variable "vm_count" {
#   default = 1
# }

# variable "public_key_path" {
#   type        = string
#   description = "Ruta para la clave pública de acceso a las instancias"
#   default     = "~/.ssh/id_rsa.pub"
# }

# variable "ssh_user" {
#   type        = string
#   description = "Usuario para hacer ssh"
#   default     = "contenedor"
# }

