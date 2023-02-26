resource "azurerm_virtual_network" "vnet" {
    name                        = var.virtual_network_name
    resource_group_name         = var.resource_group_name
    location                    = var.location
    address_space               = var.virtual_network_address_space
}
resource "azurerm_subnet" "subnet" {
  name                 = "endpoint-subnet"
  address_prefixes     = var.subnet_address_prefixes
  virtual_network_name = azurerm_virtual_network.vnet.name
  resource_group_name  = var.resource_group_name
  
}
/*resource "azurerm_subnet" "subnet" {
    name                    = var.subnet_name
    resource_group_name     = var.resource_group_name
    virtual_network_name    = azurerm_virtual_network.vnet.name
    address_prefixes        = var.subnet_address_prefixes
    private_endpoint_network_policies_enabled = true
  #private_endpoint_network_policies_enabled = true
}*/



# we will create private endpoint in this subnet
/*resource "azurerm_subnet" "endpoint_subnet" {
  name                 = var.subnet_name2
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.subnet_address_prefixes2

  enforce_private_link_endpoint_network_policies = true
}*/

resource "azurerm_virtual_network" "basvnet" {
    name                        = var.basvirtual_network_name
    resource_group_name         = var.resource_group_name
    location                    = var.location
    address_space               = var.basvirtual_network_address_space
}
resource "azurerm_subnet" "bassubnet" {
    name                    = var.bassubnet_name
    resource_group_name     = var.resource_group_name
    virtual_network_name    = azurerm_virtual_network.basvnet.name
    address_prefixes        = var.bassubnet_address_prefixes
    enforce_private_link_endpoint_network_policies = true
    #private_endpoint_network_policies_enabled = true
}
