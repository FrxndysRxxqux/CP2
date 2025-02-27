
# IP Pública para la VM Podman
resource "azurerm_public_ip" "podman_pip" {
  name                = var.podman_pip_name
  resource_group_name = var.resource_group_name
  location            = var.location_name
  allocation_method   = "Dynamic"
  
  depends_on = [azurerm_resource_group.rg]
}

# Interfaz de Red para Podman
resource "azurerm_network_interface" "podman_nic" {
  name                = var.podman_nic_name
  resource_group_name = var.resource_group_name
  location            = var.location_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.services_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.podman_pip.id
  }
}

# Asociar NSG a la interfaz de red
resource "azurerm_network_interface_security_group_association" "podman_nsg_association" {
  network_interface_id      = azurerm_network_interface.podman_nic.id
  network_security_group_id = azurerm_network_security_group.container_nsg.id
}

# Máquina Virtual con Podman
resource "azurerm_linux_virtual_machine" "podman_vm" {
  name                = var.podman_vm_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  size                = "Standard_B2s"  # Un poco más potente para contenedores
  admin_username      = var.podman_vm_username

  network_interface_ids = [
    azurerm_network_interface.podman_nic.id,
  ]

  admin_ssh_key {
    username   =  var.podman_vm_username
    public_key = file("../.ssh/vm_key.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"  # Nuevo offer para Ubuntu 20.04
    sku       = "20_04-lts"
    version   = "latest"
  }

}





