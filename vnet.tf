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
