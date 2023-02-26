resource "azurerm_virtual_network_peering" "vnet-1" {
  name                      = "vnetpeer1to2"
  resource_group_name       = var.resource_group_name
  virtual_network_name      = var.virtual_network_name
  remote_virtual_network_id = var.basvnet_id
}

resource "azurerm_virtual_network_peering" "example-2" {
  name                      = "vnetpeer2to1"
  resource_group_name       = var.resource_group_name
  virtual_network_name      = var.basvirtual_network_name
  remote_virtual_network_id = var.vnet_id
}