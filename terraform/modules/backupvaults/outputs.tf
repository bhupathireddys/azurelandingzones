output "backup_vault_id" {
  description = "Recovery Services Vault ID"
  value       = azurerm_recovery_services_vault.backup_vault.id
}

output "backup_vault_name" {
  description = "Recovery Services Vault Name"
  value       = azurerm_recovery_services_vault.backup_vault.name
}

output "backup_policy_id" {
  description = "Backup Policy ID"
  value       = azurerm_backup_policy_vm.daily.id
}

output "backup_vault_rg_name" {
  description = "Resource Group Name containing the vault"
  value       = azurerm_resource_group.vault_rg.name
}
output "backup_vault_location" {
  description = "Location of the Recovery Services Vault"
  value       = azurerm_recovery_services_vault.backup_vault.location
}