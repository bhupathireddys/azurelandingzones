data "azurerm_role_definition" "policy_audit_role" {
  name  = "Policy Storage Private Endpoint Auditor"
  scope = var.management_group_id
}

resource "azurerm_role_assignment" "policy_audit_role_assignment" {
  principal_id       = var.policy_uami_principal_id
  role_definition_id = data.azurerm_role_definition.policy_audit_role.role_definition_resource_id
  scope              = var.management_group_id
}