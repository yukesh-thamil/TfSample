resource "azurerm_private_dns_zone" "example" {
  name                = var.private_dns_zone_name
  resource_group_name = var.resource_group_name
  
}

resource "azurerm_private_dns_zone_virtual_network_link" "network_link" {
  name                  = "vnet_link"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.example.name
  virtual_network_id    = var.basvnet_id
}
resource "azurerm_private_endpoint" "endpoint" {
  name                = "priend-stor-terra"
  resource_group_name = var.resource_group_name
  location            = var.location
  subnet_id           = var.subnet_id

  private_service_connection {
    name                           = "privateend-connection"
    private_connection_resource_id = var.storageaccount_id
    is_manual_connection           = false
    subresource_names              = ["blob"]
    #depends_on = [azurerm_storage_account.storageaccount]
  }

  }



resource "azurerm_private_dns_a_record" "dns_a" {
  name                = "private-dns-record"
  zone_name           = var.private_dns_zone_name
  resource_group_name = var.resource_group_name
  ttl                 = 300
  records             = [azurerm_private_endpoint.endpoint.private_service_connection.0.private_ip_address]
}