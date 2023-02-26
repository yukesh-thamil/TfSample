resource  "azurerm_public_ip" "uma-vmpublicip"   { 
   name   =   var.my_ip
   location   =   var.location
   resource_group_name   =  var.resource_group_name 
   allocation_method   =   "Dynamic" 
   sku   =   "Basic" 
 } 


resource "azurerm_network_interface" "nic" {
    name                = "${var.bastionvmname}-nic-01"
    location            = var.location
    resource_group_name = var.resource_group_name
    ip_configuration {
        name                          = "ipconfiguration1"
        subnet_id                     = var.bassubnet_id
        private_ip_address_allocation = "Dynamic"
        public_ip_address_id   = azurerm_public_ip.uma-vmpublicip.id 
    }
}

resource "azurerm_linux_virtual_machine" "vm" {
    name                  = var.bastionvmname
    resource_group_name   = var.resource_group_name
    location              = var.location
    size                  = var.vm_size
    admin_username        = var.admin_usename
    admin_password        = var.admin_password
    network_interface_ids = [
    azurerm_network_interface.nic.id,
  ]
   
    #disable_password_authentication = false
    disable_password_authentication = false
    
    os_disk {
        name                    = "${var.bastionvmname}-os-disk-01"
        caching                 = "ReadWrite"
        storage_account_type    = var.os_disk_type
    }
    source_image_reference {
        publisher = var.image_publisher
        offer     = var.image_offer
        sku       = var.image_sku
        version   = "latest"
    }
}