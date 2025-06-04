resource "azurerm_policy_definition" "enforce_vm_encryption_at_host" {
  name                = "enforce-vm-encryptionatHost"
  policy_type         = "Custom"
  mode                = "All"
  display_name        = "Enforce Encryption At Host for VMs"
  description         = "Deny creation of virtual machines if encryption at host is not enabled."
  management_group_id = var.management_group_id

  metadata = jsonencode({
    version  = "1.0.0",
    category = "Compute"
  })

  policy_rule = file("${path.module}/enforce-vm-encryption-at-host-policy.json")
  parameters  = jsonencode({})
}

resource "azurerm_management_group_policy_assignment" "enforce_vm_encryption_at_host" {
  name                 = "enforce-encryptionhost"
  display_name         = "Enforce Encryption At Host for VMs"
  policy_definition_id = azurerm_policy_definition.enforce_vm_encryption_at_host.id
  management_group_id  = var.management_group_id
  location             = var.location
  enforce              = true

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.policy_uami.id]
  }

  non_compliance_message {
    content = "All VMs must have encryption at host enabled."
  }

  depends_on = [
    azurerm_user_assigned_identity.policy_uami,
    azurerm_policy_definition.enforce_vm_encryption_at_host
  ]
}