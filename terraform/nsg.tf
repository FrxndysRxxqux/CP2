resource "azurerm_network_security_group" "container_nsg" {
  name                = var.container_nsg_name
  location            = var.location_name
  resource_group_name = var.resource_group_name
  
  security_rule {
    name                       = "SSH"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range         = "*"
    destination_port_range    = "22"
    source_address_prefix     = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "ContainerPorts"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range         = "*"
    destination_port_range    = "8080-8090"
    source_address_prefix     = "*"
    destination_address_prefix = "*"
  }
} 