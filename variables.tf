variable "resource_group_name" {

}
variable "location" {

}
variable "virtual_network_name" {

}
variable "virtual_network_address_space" {

}
variable "subnet_name" {}

variable "subnet_address_prefixes" {

}
variable "account_tier" {
  description = "Defines the Tier to use for this storage account. Valid options are Standard and Premium. Changing this forces a new resource to be created."
  default     = "Standard"
}

variable "account_kind" {
  description = "Defines the Kind of account. Valid options are BlobStorage, BlockBlobStorage, FileStorage, Storage and StorageV2. Changing this forces a new resource to be created. Defaults to StorageV2."
  default     = "StorageV2"
}

variable "account_replication_type" {
  description = "Defines the type of replication to use for this storage account. Valid options are LRS, GRS, RAGRS and ZRS."
  default     = "ZRS"
}

variable "access_tier" {
  description = "Defines the access tier for BlobStorage and StorageV2 accounts. Valid options are Hot and Cool."
  default     = "Hot"
}

variable "min_tls_version" {
  description = "The minimum supported TLS version for the storage account. Possible values are TLS1_0, TLS1_1, and TLS1_2."
  default     = "TLS1_2"
}

variable "soft_delete_retention" {
  description = "Number of retention days for soft delete. If set to null it will disable soft delete all together."
  type        = number
  default     = 31
}

variable "cors_rule" {
  description = "CORS rules for storage account."
  type = list(object({
    allowed_origins    = list(string)
    allowed_methods    = list(string)
    allowed_headers    = list(string)
    exposed_headers    = list(string)
    max_age_in_seconds = number
  }))
  default = []
}

/*variable "network_rules" {
  description = "Network rules restricting access to the storage account."
  type = object({
    ip_rules   = list(string)
    subnet_ids = list(string)
    bypass     = list(string)
  })
  default = null
}*/
variable "tags" {
  description = "Tags to apply to all resources created."
  type        = map(string)
  default     = {}
}

variable "storage_name" {

}


variable "private_dns_zone_name" {

}


variable "vmname" {

}
variable "bastionvmname" {

}

variable "vm_size" {

}
variable "os_disk_type" {

}
variable "admin_usename" {

}
variable "admin_password" {

}
variable "image_publisher" {

}
variable "image_offer" {

}
variable "image_sku" {

}
variable "my_ip" {}
#variable "white_list_ip"{}
variable "basvirtual_network_name" {

}

variable "basvirtual_network_address_space" {

}

variable "bassubnet_name" {

}
variable "bassubnet_address_prefixes" {

}