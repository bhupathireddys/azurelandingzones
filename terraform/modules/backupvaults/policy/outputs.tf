output "auto_enable_backup_dev_policy_definition_id" {
  description = "Policy Definition ID for auto-enable backup for dev VMs"
  value       = azurerm_policy_definition.auto_enable_backup_dev.id
}

# output "auto_enable_backup_qa_policy_definition_id" {
#   description = "Policy Definition ID for auto-enable backup for qa VMs"
#   value       = azurerm_policy_definition.auto_enable_backup_qa.id
# }

# output "auto_enable_backup_stg_policy_definition_id" {
#   description = "Policy Definition ID for auto-enable backup for stg VMs"
#   value       = azurerm_policy_definition.auto_enable_backup_stg.id
# }

# output "auto_enable_backup_prd_policy_definition_id" {
#   description = "Policy Definition ID for auto-enable backup for prd VMs"
#   value       = azurerm_policy_definition.auto_enable_backup_prd.id
# }
