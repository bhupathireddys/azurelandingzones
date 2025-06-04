resource "azurerm_role_definition" "policy_audit_role" {
  name        = "Policy Storage Private Endpoint Auditor"
  scope       = var.management_group_id
  description = "Custom role for auditing storage private endpoints"

  permissions {
    actions = [
      "Microsoft.Storage/storageAccounts/read",
      "Microsoft.Network/privateEndpoints/read",
      "Microsoft.Network/privateDnsZones/read"
    ]
    not_actions = []
  }

  assignable_scopes = [var.management_group_id]
}

resource "azurerm_role_assignment" "policy_audit" {
  scope              = var.management_group_id
  role_definition_id = azurerm_role_definition.policy_audit_role.role_definition_resource_id
  principal_id       = var.policy_uami_principal_id
}