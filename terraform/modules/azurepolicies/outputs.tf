# Policy Definitions
output "policy_definition_ids" {
  description = "Map of all policy definition IDs"
  value = {
    central_diagnostics           = azurerm_policy_definition.central_diagnostics.id
    enforce_tls12_appservice      = azurerm_policy_definition.enforce_tls12_appservice.id
    audit_keyvault_softdelete     = azurerm_policy_definition.audit_keyvault_softdelete.id
    deny_insecure_nsg_any_any     = azurerm_policy_definition.deny_insecure_nsg_any_any.id
    deny_rdp_ssh_from_internet    = azurerm_policy_definition.deny_rdp_ssh_from_internet.id
    audit_public_storage_access   = azurerm_policy_definition.audit_public_storage_access.id
    deploy_keyvault_softdelete    = azurerm_policy_definition.deploy_keyvault_softdelete.id
    enforce_vm_encryption_at_host = azurerm_policy_definition.enforce_vm_encryption_at_host.id
    restrict_vm_sizes             = azurerm_policy_definition.restrict_vm_sizes.id
  }
}

# Policy Assignments
output "policy_assignment_ids" {
  description = "Map of all policy assignment IDs"
  value = {
    diagnostics_assignments      = { for k, v in azurerm_subscription_policy_assignment.diagnostics_assignments : k => v.id }
    enforce_tls12_appservice     = azurerm_management_group_policy_assignment.enforce_tls12_appservice.id
    audit_keyvault_softdelete    = azurerm_management_group_policy_assignment.audit_keyvault_softdelete.id
    deny_insecure_nsg_any_any    = azurerm_management_group_policy_assignment.deny_insecure_nsg_any_any.id
    deny_rdp_ssh_from_internet   = azurerm_management_group_policy_assignment.deny_rdp_ssh_from_internet.id
    audit_public_storage_access  = azurerm_management_group_policy_assignment.audit_public_storage_access.id
    deploy_keyvault_softdelete   = azurerm_management_group_policy_assignment.deploy_keyvault_softdelete.id
    enforce_vm_encryption_at_host= azurerm_management_group_policy_assignment.enforce_vm_encryption_at_host.id
    restrict_vm_sizes            = azurerm_management_group_policy_assignment.restrict_vm_sizes.id
  }
}

# Custom Role Outputs
output "custom_role_definition_id" {
  description = "ID of the custom role created for policy auditing"
  value       = azurerm_role_definition.policy_audit_role.role_definition_resource_id
}

