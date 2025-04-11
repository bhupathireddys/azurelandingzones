# resource "azurerm_network_watcher" "hub" {
#   name                = "NetworkWatcher"
#   location            = var.location
#   resource_group_name = var.resource_group_name
# }

# resource "azurerm_network_watcher_flow_log" "hub" {
#   name                      = "hub-flow-log"
#   network_watcher_name      = azurerm_network_watcher.hub.name
#   resource_group_name       = var.resource_group_name
#   storage_account_id        = var.storage_account_id
#   enabled                   = true
  
#   retention_policy {
#     enabled = true
#     days    = var.retention_days
#   }

#   traffic_analytics {
#     enabled               = var.traffic_analytics_enabled
#     workspace_id         = var.workspace_id
#     workspace_region     = var.location
#     workspace_resource_id = var.workspace_resource_id
#   }
# }