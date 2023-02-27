terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

module "virtual-network" {
  source                        = "./virtual network"
  virtual_network_name          = var.virtual_network_name
  resource_group_name           = var.resource_group_name
  location                      = var.location
  virtual_network_address_space = var.virtual_network_address_space
  subnet_name                   = var.subnet_name
  subnet_address_prefixes       = var.subnet_address_prefixes
  #subnet_address_prefixes2        = var.subnet_address_prefixes2
  basvirtual_network_name          = var.basvirtual_network_name
  basvirtual_network_address_space = var.basvirtual_network_address_space
  bassubnet_name                   = var.bassubnet_name
  bassubnet_address_prefixes       = var.bassubnet_address_prefixes

}

module "Peering-virtual-network" {
  source = "./vnet peering"
  #virtual_network_name            = var.virtual_network_name
  resource_group_name     = var.resource_group_name
  virtual_network_name    = var.virtual_network_name
  basvnet_id              = module.virtual-network.basvnet_id
  basvirtual_network_name = var.basvirtual_network_name
  vnet_id                 = module.virtual-network.vnet_id
}

module "virtual-machine" {
  source              = "./virtual machine"
  vmname              = var.vmname
  location            = var.location
  resource_group_name = var.resource_group_name
  #network_interface_ids   = [module.network-interface.nic_id]
  #my_ip                    = var.my_ip
  subnet_id       = module.virtual-network.subnet_id
  vm_size         = var.vm_size
  os_disk_type    = var.os_disk_type
  admin_usename   = var.admin_usename
  admin_password  = var.admin_password
  image_publisher = var.image_publisher
  image_offer     = var.image_offer
  image_sku       = var.image_sku

}
module "bastion-virtual-machine" {
  source              = "./bastion vm"
  bastionvmname       = var.bastionvmname
  location            = var.location
  resource_group_name = var.resource_group_name
  #network_interface_ids   = [module.network-interface.nic_id]
  my_ip           = var.my_ip
  bassubnet_id    = module.virtual-network.bassubnet_id
  vm_size         = var.vm_size
  os_disk_type    = var.os_disk_type
  admin_usename   = var.admin_usename
  admin_password  = var.admin_password
  image_publisher = var.image_publisher
  image_offer     = var.image_offer
  image_sku       = var.image_sku

}



module "storage_account" {
  source                   = "./storage account"
  storage_name             = var.storage_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_kind             = var.account_kind
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type
  access_tier              = var.access_tier
  #enable_https_traffic_only = true
  min_tls_version = var.min_tls_version
  #name = "demo"
  /*subnet_id = module.virtual-network.subnet_id
  vnet_id  = module.virtual-network.vnet_id
  #storageaccount_id= module.storage_account.storageaccount_id
 # private_link_enabled_resource_id = module.storage_account.storageaccount_id
  private_dns_zone_name = var.private_dns_zone_name
  #subresource_names = ["blob"]*/




}

module "privateendpoint" {
  source = "./privateendpoint/"

  resource_group_name = var.resource_group_name
  location            = var.location
  #name = "demo"


  subnet_id         = module.virtual-network.subnet_id
  basvnet_id        = module.virtual-network.basvnet_id
  storageaccount_id = module.storage_account.storageaccount_id
  #private_link_enabled_resource_id = module.storage_account.storageaccount_id
  private_dns_zone_name = var.private_dns_zone_name
  #subresource_names = ["blob"]


}