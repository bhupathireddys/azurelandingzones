resource "azurerm_resource_group" "identity_rg" {
  name     = var.identity_settings.resource_group
  location = var.identity_settings.location
}

resource "azurerm_user_assigned_identity" "policy_uami" {
  name                = var.identity_settings.identity_name
  resource_group_name = azurerm_resource_group.identity_rg.name
  location            = azurerm_resource_group.identity_rg.location
}

resource "azurerm_role_assignment" "uami_contributor" {
  scope                = var.identity_settings.assignment_scope
  role_definition_name = "Contributor"
  principal_id         = azurerm_user_assigned_identity.policy_uami.principal_id
}

resource "azurerm_role_assignment" "uami_policy" {
  scope                = var.identity_settings.assignment_scope
  role_definition_name = "Resource Policy Contributor"
  principal_id         = azurerm_user_assigned_identity.policy_uami.principal_id
}
resource "azurerm_role_assignment" "uami_monitoring" {
  scope                = var.identity_settings.assignment_scope
  role_definition_name = "Monitoring Contributor"
  principal_id         = azurerm_user_assigned_identity.policy_uami.principal_id
}