resource "azurerm_policy_definition" "audit_keyvault_softdelete" {
  name                = "audit-kv-softdel"
  policy_type         = "Custom"
  mode                = "All"
  display_name        = "Audit Key Vaults without soft-delete/purge protection"
  description         = "Audits Key Vaults that do not have soft-delete and purge protection enabled."
  management_group_id = var.management_group_id

  policy_rule = file("${path.module}/policy-defs/audit-keyvault-softdelete-policy.json")
  parameters  = jsonencode({})
}

resource "azurerm_management_group_policy_assignment" "audit_keyvault_softdelete" {
  name                 = "audit-kv-softdel"
  display_name         = "Audit Key Vault Soft-Delete & Purge Protection"
  policy_definition_id = azurerm_policy_definition.audit_keyvault_softdelete.id
  management_group_id  = var.management_group_id
  location             = var.policy_uami_location
  enforce              = true

  identity {
    type         = "UserAssigned"
    identity_ids = [var.policy_uami_id]
  }

  non_compliance_message {
    content = "Key Vaults must have soft-delete and purge protection enabled."
  }
}
