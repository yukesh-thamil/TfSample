variable "storage_name"{

}
variable "location" {
    
}
variable "resource_group_name" {

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
  
  type        = number
  default     = 31
}

variable "cors_rule" {
  
  type = list(object({
    allowed_origins    = list(string)
    allowed_methods    = list(string)
    allowed_headers    = list(string)
    exposed_headers    = list(string)
    max_age_in_seconds = number
  }))
  default = []
}
#Network rules restricting access to the storage account
variable "network_rules" {
  
  type = object({
    ip_rules   = list(string)
    subnet_ids = list(string)
    bypass     = list(string)
  })
  default = null
}
variable "tags" {
  description = "Tags to apply to all resources created."
  type        = map(string)
  default     = {}
}





