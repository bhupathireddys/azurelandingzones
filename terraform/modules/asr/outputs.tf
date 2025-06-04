output "asr_vault_id" {
  description = "ID of the ASR Recovery Services Vault"
  value       = azurerm_recovery_services_vault.asr_vault.id
}

output "asr_vault_name" {
  description = "Name of the ASR Recovery Services Vault"
  value       = azurerm_recovery_services_vault.asr_vault.name
}

output "asr_vault_rg" {
  description = "Resource Group of the ASR Vault"
  value       = azurerm_resource_group.asr_rg.name
}

output "asr_vault_location" {
  description = "Primary Region where ASR Vault is created"
  value       = azurerm_resource_group.asr_rg.location
}
