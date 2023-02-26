output "vnet_id"{
    value = azurerm_virtual_network.vnet.id
}
output "subnet_id" {
    value = azurerm_subnet.subnet.id
}
output "basvnet_id"{
    value = azurerm_virtual_network.basvnet.id
}
output "bassubnet_id" {
    value = azurerm_subnet.bassubnet.id
}