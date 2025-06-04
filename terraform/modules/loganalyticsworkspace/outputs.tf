output "workspace_ids" {
  value = {
    for key, ws in azurerm_log_analytics_workspace.lawspace : key => ws.id
  }
  description = "Workspace resource IDs by region"
}

output "storage_account_ids" {
  description = "Secure storage account IDs per region"
  value = {
    for key, sa in azurerm_storage_account.primestorage : key => sa.id
  }
}

output "automation_account_ids" {
  description = "Automation account IDs per region"
  value = {
    for key, aa in azurerm_automation_account.automation : key => aa.id
  }
}
