data "azurerm_resource_group" "identity_rg" {
  name     = var.identity_resource_group
}

resource "azurerm_user_assigned_identity" "policy_uami" {
  name                = "policy-remediation-identity"
  resource_group_name = data.azurerm_resource_group.identity_rg.name
  location            = data.azurerm_resource_group.identity_rg.location
}

resource "azurerm_role_assignment" "uami_contributor" {
  scope              = var.assignment_scope
  role_definition_name = "Contributor"
  principal_id       = azurerm_user_assigned_identity.policy_uami.principal_id
}

resource "azurerm_role_assignment" "uami_policy" {
  scope              = var.assignment_scope
  role_definition_name = "Resource Policy Contributor"
  principal_id       = azurerm_user_assigned_identity.policy_uami.principal_id
}
