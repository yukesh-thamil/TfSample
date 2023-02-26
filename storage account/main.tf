resource "azurerm_storage_account" "storageaccount" {
  name              = var.storage_name
  resource_group_name       = var.resource_group_name
  location                  = var.location
  account_kind              = var.account_kind
  account_tier              = var.account_tier
  account_replication_type  = var.account_replication_type
  access_tier               = var.access_tier
  enable_https_traffic_only = true
  min_tls_version           = var.min_tls_version

  blob_properties {
    delete_retention_policy {
      days = var.soft_delete_retention
      depends_on = [azurerm_storage_account.storageaccount]
    }
    dynamic "cors_rule" {
      for_each = var.cors_rule
      content {
        allowed_origins    = cors_rule.value.allowed_origins
        allowed_methods    = cors_rule.value.allowed_methods
        allowed_headers    = cors_rule.value.allowed_headers
        exposed_headers    = cors_rule.value.exposed_headers
        max_age_in_seconds = cors_rule.value.max_age_in_seconds
      }
    }
  }

  
  tags = var.tags
}
resource "azurerm_storage_container" "container" {
  name                  = "demo"
  storage_account_name  = azurerm_storage_account.storageaccount.name
  container_access_type = "private"
  #depends_on = [azurerm_storage_account.storageaccount]
}
resource "azurerm_storage_share" "example" {
  name                 = "uma"
  storage_account_name = azurerm_storage_account.storageaccount.name
  quota                = 50
}

resource "azurerm_storage_share_file" "example" {
  name             = "test.html"
  storage_share_id = azurerm_storage_share.example.id
  source           = "file:///C:/Users/umadevi.sam/Downloads/test.html"
}
resource "azurerm_storage_account_network_rules" "rules" {
  storage_account_id = azurerm_storage_account.storageaccount.id
  default_action     = "Deny"
  bypass             = ["Metrics", "Logging", "AzureServices"]
}


/*resource "azurerm_storage_blob" "file" {
  name                   = "my-awesome-content"
  storage_account_name   = azurerm_storage_account.storageaccount.name
  storage_container_name = azurerm_storage_container.blobcontainer.name
  type                   = "Block"
  source                 = "C:\Users\umadevi.sam\Downloads"
}
resource "azurerm_storage_blob" "uma" {
    + access_tier            = (known after apply)
    + content_type           = "application/octet-stream"
    + id                     = (known after apply)
    + metadata               = (known after apply)
    + name                   = "test.txt"
    + parallelism            = 8
    + size                   = 0
    + source                 = "file_uploads/test.txt"
    + storage_account_name   = "tamopsdatasa"
    + storage_container_name = "tamopsdata"
    + type                   = "Block"
    + url                    = (known after apply)
  }*/
 