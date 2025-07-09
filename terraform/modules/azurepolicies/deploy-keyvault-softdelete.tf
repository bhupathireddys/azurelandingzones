resource "azurerm_policy_definition" "deploy_keyvault_softdelete" {
  name                = "deploy-kv-softdelete"
  policy_type         = "Custom"
  mode                = "All"
  display_name        = "Deploy Soft-Delete & Purge Protection on Key Vaults"
  description         = "Ensures soft-delete and purge protection are enabled on new Key Vaults."
  management_group_id = var.management_group_id

  metadata = jsonencode({
    category = "Key Vault"
  })

  policy_rule = file("${path.module}/policy-defs/deploy-keyvault-softdelete-policy.json")
  parameters  = jsonencode({})
}

resource "azurerm_management_group_policy_assignment" "deploy_keyvault_softdelete" {
  name                 = "deploy-kv-softdelete"
  display_name         = "Deploy Soft-Delete & Purge Protection on Key Vaults"
  policy_definition_id = azurerm_policy_definition.deploy_keyvault_softdelete.id
  management_group_id  = var.management_group_id
  location             = var.policy_uami_location
  enforce              = true

  identity {
    type         = "UserAssigned"
    identity_ids = [var.policy_uami_id]
  }

  non_compliance_message {
    content = "Key Vaults will be automatically configured with soft-delete and purge protection."
  }

  depends_on = [azurerm_policy_definition.deploy_keyvault_softdelete]
}
