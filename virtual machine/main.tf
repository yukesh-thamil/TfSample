resource "azurerm_network_interface" "nic" {
  name                = "example-nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "vm" {
 name                  = var.vmname
    resource_group_name   = var.resource_group_name
    location              = var.location
    size                  = var.vm_size
    admin_username        = var.admin_usename
    admin_password        = var.admin_password
    disable_password_authentication = false
  network_interface_ids = [
    azurerm_network_interface.nic.id,
  ]

  

  os_disk {
    name                 = "${var.vmname}-os-disk-01"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
        publisher = var.image_publisher
        offer     = var.image_offer
        sku       = var.image_sku
        version   = "latest"
    }

  /*source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }*/
}