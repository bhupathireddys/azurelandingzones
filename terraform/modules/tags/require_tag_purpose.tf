resource "azurerm_policy_definition" "require_tag_purpose" {
  name                = "require-tag-purpose"
  policy_type         = "Custom"
  mode                = "Indexed"
  management_group_id = var.management_group_id
  display_name        = "Require 'purpose' tag on relevant resources"
  description         = "Audit or deny if 'purpose' tag is missing on specified resource types"

  policy_rule = jsonencode({
    "if": {
      "allOf": [
        {
          "field": "type",
          "in": [
            "Microsoft.Web/sites",
            "Microsoft.Storage/storageAccounts",
            "Microsoft.DataFactory/factories",
            "Microsoft.KeyVault/vaults",
            "Microsoft.Sql/servers",
            "Microsoft.Databricks/workspaces",
            "Microsoft.RecoveryServices/vaults"
          ]
        },
        {
          "field": "tags.purpose",
          "exists": "false"
        }
      ]
    },
    "then": {
      "effect": "[parameters('effect')]",
      "details": {
        "type": "Microsoft.Resources/tags",
        "existenceCondition": {
          "field": "tags.purpose",
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
