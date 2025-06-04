resource "azurerm_policy_definition" "auto_enable_backup_qa" {
  name         = "auto-enable-backup-qa"
  policy_type  = "Custom"
  mode         = "Indexed"
  display_name = "Auto-Enable Backup for qa VMs"
  description  = "Automatically enable backup for VMs in 'qa' environment tagged with backup=Yes."

  management_group_id = var.management_group_id

  metadata = <<METADATA
{
  "version": "1.0.0",
  "category": "Backup"
}
METADATA

  parameters = jsonencode({
    "vaultName": {
      "type": "String",
      "metadata": {
        "displayName": "Backup Vault Name",
        "description": "The name of the Recovery Services Vault"
      }
    },
    "backupPolicyId": {
      "type": "String",
      "metadata": {
        "displayName": "Backup Policy ID",
        "description": "The resource ID of the backup policy to apply"
      }
    }
  })

  policy_rule = jsonencode({
    "if": {
      "allOf": [
        {
          "field": "type",
          "equals": "Microsoft.Compute/virtualMachines"
        },
        {
          "field": "tags['backup']",
          "equals": "Yes"
        },
        {
          "field": "tags['env']",
          "equals": "qa"
        }
      ]
    },
    "then": {
      "effect": "deployIfNotExists",
      "details": {
        "type": "Microsoft.RecoveryServices/vaults/backupFabrics/protectionContainers/protectedItems",
        "roleDefinitionIds": [
          "/providers/Microsoft.Authorization/roleDefinitions/9980e02c-c2be-4d73-94e8-173b1dc7cf3c" // Backup Contributor role
        ],
        "deployment": {
          "properties": {
            "mode": "incremental",
            "parameters": {
              "vaultName": {
                "value": "[parameters('vaultName')]"
              },
              "backupPolicyId": {
                "value": "[parameters('backupPolicyId')]"
              }
            },
            "template": {
              "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#",
              "contentVersion": "1.0.0.0",
              "parameters": {
                "vaultName": {
                  "type": "String"
                },
                "backupPolicyId": {
                  "type": "String"
                }
              },
              "resources": [
                {
                  "type": "Microsoft.RecoveryServices/vaults/backupFabrics/protectionContainers/protectedItems",
                  "apiVersion": "2022-02-01",
                  "name": "[concat(parameters('vaultName'), '/Azure/iaasvmcontainer;iaasvmcontainerv2;', field('resourceGroupName'), ';', field('name'), '/vm;iaasvmcontainerv2;', field('resourceGroupName'), ';', field('name'))]",
                  "properties": {
                    "protectedItemType": "Microsoft.Compute/virtualMachines",
                    "sourceResourceId": "[field('id')]",
                    "policyId": "[parameters('backupPolicyId')]"
                  }
                }
              ]
            }
          }
        }
      }
    }
  })
}