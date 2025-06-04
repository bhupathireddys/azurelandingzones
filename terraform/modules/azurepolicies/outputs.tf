output "activitylogs_policy_definition_id" {
  description = "ID of the activity logs policy definition"
  value       = azurerm_policy_definition.sub_activity_laws.id
}

output "diagnostic_policy_definition_id" {
  description = "ID of the diagnostic settings policy definition"
  value       = azurerm_policy_definition.enable_diagnostic_settings.id
}

output "activitylogs_policy_assignment_id" {
  description = "ID of the activity logs policy assignment at management group"
  value       = azurerm_management_group_policy_assignment.activitylogs_global.id
}

output "diagnostic_policy_assignment_id" {
  description = "ID of the diagnostic settings policy assignment at management group"
  value       = azurerm_management_group_policy_assignment.diagnosticsettings_global.id
}

output "policy_uami_id" {
  description = "ID of the user-assigned managed identity used for policy remediation"
  value       = azurerm_user_assigned_identity.policy_uami.id
}

output "policy_uami_client_id" {
  description = "Client ID of the policy UAMI"
  value       = azurerm_user_assigned_identity.policy_uami.client_id
}

output "policy_uami_principal_id" {
  description = "Principal ID of the policy UAMI"
  value       = azurerm_user_assigned_identity.policy_uami.principal_id
}

output "policy_uami_name" {
  description = "Name of the policy UAMI"
  value       = azurerm_user_assigned_identity.policy_uami.name
}

output "policy_uami_rg" {
  description = "Resource group of the policy UAMI"
  value       = var.identity_resource_group
}
