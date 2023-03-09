# Resource Group For Web App Project
resource "azurerm_resource_group" "web-rg" {
  name     = "web-rg"
  location = "East US"
    tags = {
    env = "dev"
    tier = "frontend"
  }
}