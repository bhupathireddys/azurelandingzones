output "workspace_id" {
  description = "Log Analytics Workspace ID"
  value       = azurerm_log_analytics_workspace.lawspace.id
}

output "workspace_customer_id" {
  description = "Log Analytics Workspace Customer ID"
  value = azurerm_log_analytics_workspace.lawspace.workspace_id

}

output "workspace_name" {
  description = "Log Analytics Workspace Name"
  value       = azurerm_log_analytics_workspace.lawspace.name
}

output "law_resource_group_name" {
  description = "Resource Group Name of Log Analytics Workspace"
  value       = azurerm_resource_group.lawsrg.name
}

output "automation_account_id" {
  description = "Automation Account ID"
  value       = azurerm_automation_account.automation.id
}

output "storage_account_id" {
  description = "Storage Account ID used for LAW export"
  value       = azurerm_storage_account.primestorage.id
}
output "workspace_location" {
  value = azurerm_resource_group.lawsrg.location
}
