output "policy_uami_id" {
  value       = azurerm_user_assigned_identity.policy_uami.id
  description = "The ID of the user-assigned managed identity"
}

output "policy_uami_client_id" {
  value       = azurerm_user_assigned_identity.policy_uami.client_id
  description = "The client ID of the user-assigned managed identity"
}

output "policy_uami_principal_id" {
  value       = azurerm_user_assigned_identity.policy_uami.principal_id
  description = "The principal ID of the user-assigned managed identity"
}
output "policy_uami_location" {
  value = azurerm_user_assigned_identity.policy_uami.location
}
