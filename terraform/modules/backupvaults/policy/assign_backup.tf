# modules/backupvaults/policy/assign_backup.tf
resource "azurerm_role_assignment" "backup_contributor" {
  scope                = var.management_group_id
  role_definition_name = "Backup Contributor"
  principal_id         = var.policy_uami_principal_id # Using the separate variable
}
resource "azurerm_management_group_policy_assignment" "assign_auto_backup_dev" {
  name                 = "auto-enable-backup-dev"
  management_group_id  = var.management_group_id
  policy_definition_id = azurerm_policy_definition.auto_enable_backup_dev.id
  location = var.location

  identity {
    type         = "UserAssigned"
    identity_ids = [var.policy_uami_id]
  }

  parameters = jsonencode({
    "vaultName": {
      "value": var.backup_mapping.dev.vault_name
    },
    "backupPolicyId": {
      "value": var.backup_mapping.dev.backup_policy_id
    }
  })
}

resource "azurerm_management_group_policy_assignment" "assign_auto_backup_qa" {
  name                 = "auto-enable-backup-qa"
  management_group_id  = var.management_group_id
  policy_definition_id = azurerm_policy_definition.auto_enable_backup_qa.id
  location = var.location
  
  identity {
    type         = "UserAssigned"
    identity_ids = [var.policy_uami_id]
  }

  parameters = jsonencode({
    "vaultName": {
      "value": var.backup_mapping.qa.vault_name
    },
    "backupPolicyId": {
      "value": var.backup_mapping.qa.backup_policy_id
    }
  })
}

resource "azurerm_management_group_policy_assignment" "assign_auto_backup_stg" {
  name                 = "auto-enable-backup-stg"
  management_group_id  = var.management_group_id
  policy_definition_id = azurerm_policy_definition.auto_enable_backup_stg.id
  location = var.location

  identity {
    type         = "UserAssigned"
    identity_ids = [var.policy_uami_id]
  }

  parameters = jsonencode({
    "vaultName": {
      "value": var.backup_mapping.stg.vault_name
    },
    "backupPolicyId": {
      "value": var.backup_mapping.stg.backup_policy_id
    }
  })
}
resource "azurerm_management_group_policy_assignment" "assign_auto_backup_prd" {
  name                 = "auto-enable-backup-prd"
  management_group_id  = var.management_group_id
  policy_definition_id = azurerm_policy_definition.auto_enable_backup_prd.id
  location = var.location

  identity {
    type         = "UserAssigned"
    identity_ids = [var.policy_uami_id]
  }

  parameters = jsonencode({
    "vaultName": {
      "value": var.backup_mapping.prd.vault_name
    },
    "backupPolicyId": {
      "value": var.backup_mapping.prd.backup_policy_id
    }
  })
}