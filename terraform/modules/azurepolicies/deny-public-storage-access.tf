resource "azurerm_policy_definition" "audit_public_storage_access" {
  name                = "audit-public-storage-access"
  policy_type         = "Custom"
  mode                = "All"
  display_name        = "Audit Public Access on Storage Accounts"
  description         = "Audits storage accounts that allow public blob or shared key access."
  management_group_id = var.management_group_id

  metadata = jsonencode({
    version  = "1.0.1",
    category = "Storage"
  })

  policy_rule = file("${path.module}/policy-defs/deny-public-storage-access-policy.json")
  parameters  = jsonencode({})
}

resource "azurerm_management_group_policy_assignment" "audit_public_storage_access" {
  name                 = "audit-public-storage"
  display_name         = "Audit Public Access to Storage Accounts"
  policy_definition_id = azurerm_policy_definition.audit_public_storage_access.id
  management_group_id  = var.management_group_id
  location             = var.policy_uami_location
  enforce              = true

  identity {
    type         = "UserAssigned"
    identity_ids = [var.policy_uami_id]
  }

  non_compliance_message {
    content = "Storage accounts should not allow public blob or shared key access."
  }

  depends_on = [
    azurerm_policy_definition.audit_public_storage_access
  ]
}
