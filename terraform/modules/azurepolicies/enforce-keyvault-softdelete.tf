resource "azurerm_policy_definition" "enforce_keyvault_softdelete" {
  name                = "enforce-keyvault-softdelete-purgeprotection"
  policy_type         = "Custom"
  mode                = "All"
  display_name        = "Deny Key Vault creation without soft-delete and purge protection"
  description         = "Enforces soft-delete and purge protection on all Azure Key Vaults."
  management_group_id = var.management_group_id

  metadata = jsonencode({
    version  = "1.0.0",
    category = "Key Vault"
  })

  policy_rule = file("${path.module}/enforce-keyvault-softdelete-policy.json")
  parameters  = jsonencode({})
}

resource "azurerm_management_group_policy_assignment" "enforce_keyvault_softdelete" {
  name                 = "enforce-keyvault-protect"
  display_name         = "Enforce Key Vault Soft-Delete & Purge Protection"
  policy_definition_id = azurerm_policy_definition.enforce_keyvault_softdelete.id
  management_group_id  = var.management_group_id
  location             = var.location
  enforce              = true

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.policy_uami.id]
  }

  non_compliance_message {
    content = "Key Vaults must have soft-delete and purge protection enabled."
  }

  depends_on = [
    azurerm_user_assigned_identity.policy_uami,
    azurerm_policy_definition.enforce_keyvault_softdelete
  ]
}