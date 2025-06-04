resource "azurerm_policy_definition" "require_tag_ownername" {
  name                = "require-tag-ownername"
  policy_type         = "Custom"
  mode                = "Indexed"
  management_group_id = var.management_group_id
  display_name        = "Require 'ownername' tag for accountable ownership"
  description         = "Audit or deny if 'ownername' tag is missing on designated resources"

  policy_rule = jsonencode({
    "if": {
      "allOf": [
        {
          "field": "type",
          "in": [
            "Microsoft.Compute/virtualMachines",
            "Microsoft.Web/sites",
            "Microsoft.Sql/servers",
            "Microsoft.KeyVault/vaults",
            "Microsoft.Storage/storageAccounts",
            "Microsoft.Automation/automationAccounts",
            "Microsoft.DataFactory/factories",
            "Microsoft.Databricks/workspaces",
            "Microsoft.Resources/resourceGroups"
          ]
        },
        {
          "field": "tags.ownername",
          "exists": "false"
        }
      ]
    },
    "then": {
      "effect": "[parameters('effect')]",
      "details": {
        "type": "Microsoft.Resources/tags",
        "existenceCondition": {
          "field": "tags.ownername",
          "exists": "true"
        }
      }
    }
  })

  parameters = jsonencode({
    effect = {
      type          = "String",
      allowedValues = ["AuditIfNotExists", "Deny"],
      defaultValue  = var.policy_effect
    }
  })

  metadata = jsonencode({ category = "Tags" })
}
