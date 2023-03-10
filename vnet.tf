# Virtual Network
resource "azurerm_virtual_network" "web-vnet" {
  name                = "web-network"
  location            = azurerm_resource_group.web-rg.location
  resource_group_name = azurerm_resource_group.web-rg.name
  address_space       = ["10.0.0.0/16"]
  tags = {
    env  = "dev"
    tier = "frontend"
  }
}

# Subnet
resource "azurerm_subnet" "web-subnet" {
  name                 = "web-subnet"
  resource_group_name  = azurerm_resource_group.web-rg.name
  virtual_network_name = azurerm_virtual_network.web-vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

# Network Security Group
resource "azurerm_network_security_group" "web-nsg" {
  name                = "web-rules"
  location            = azurerm_resource_group.web-rg.location
  resource_group_name = azurerm_resource_group.web-rg.name
  tags = {
    env = "dev"
  }
}

# Network Security Group Rules
resource "azurerm_network_security_rule" "web-ssh" {
  name                        = "ssh"
  priority                    = 500
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.web-rg.name
  network_security_group_name = azurerm_network_security_group.web-nsg.name
}

resource "azurerm_network_security_rule" "web-http" {
  name                        = "http"
  priority                    = 400
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "80"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.web-rg.name
  network_security_group_name = azurerm_network_security_group.web-nsg.name
}

# Associate NSG with Subnet
resource "azurerm_subnet_network_security_group_association" "web-nsg-assoc" {
  subnet_id                 = azurerm_subnet.web-subnet.id
  network_security_group_id = azurerm_network_security_group.web-nsg.id
}
