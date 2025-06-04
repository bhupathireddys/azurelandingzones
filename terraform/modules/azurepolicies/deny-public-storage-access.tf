resource "azurerm_policy_definition" "deny_public_storage_access" {
  name                = "deny-public-storage-access"
  policy_type         = "Custom"
  mode                = "All"
  display_name        = "Deny Public Access to Storage Accounts"
  description         = "Prevents creation of storage accounts that allow public access to blob or shared key."
  management_group_id = var.management_group_id

  metadata = jsonencode({
    version  = "1.0.0",
    category = "Storage"
  })

  policy_rule = file("${path.module}/deny-public-storage-access-policy.json")
  parameters  = jsonencode({})
}

resource "azurerm_management_group_policy_assignment" "deny_public_storage_access" {
  name                 = "deny-public-storage"
  display_name         = "Deny Public Access to Storage Accounts"
  policy_definition_id = azurerm_policy_definition.deny_public_storage_access.id
  management_group_id  = var.management_group_id
  location             = var.location
  enforce              = true

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.policy_uami.id]
  }

  non_compliance_message {
    content = "Storage accounts must not allow public blob or file access."
  }

  depends_on = [
    azurerm_user_assigned_identity.policy_uami,
    azurerm_policy_definition.deny_public_storage_access
  ]
}