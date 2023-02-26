output "public_ip" {
    value = azurerm_public_ip.uma-vmpublicip.id
  
}

output "nic_id" {
    
    value = azurerm_network_interface.nic.id
}
output "vm_id" {
    
    value = azurerm_linux_virtual_machine.vm.id
}
