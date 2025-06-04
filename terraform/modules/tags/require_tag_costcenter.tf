resource "azurerm_policy_definition" "require_tag_costcenter" {
  name                = "require-tag-costcenter"
  policy_type         = "Custom"
  mode                = "Indexed"
  management_group_id = var.management_group_id
  display_name        = "Require 'costcenter' tag for financial governance"
  description         = "Audit or deny if 'costcenter' tag is missing on chargeable resources"

  policy_rule = jsonencode({
    "if": {
      "allOf": [
        {
          "field": "type",
          "in": [
            "Microsoft.Compute/virtualMachines",
            "Microsoft.Web/sites",
            "Microsoft.Sql/servers",
            "Microsoft.Databricks/workspaces",
            "Microsoft.Storage/storageAccounts"
          ]
        },
        {
          "field": "tags.costcenter",
          "exists": "false"
        }
      ]
    },
    "then": {
      "effect": "[parameters('effect')]",
      "details": {
        "type": "Microsoft.Resources/tags",
        "existenceCondition": {
          "field": "tags.costcenter",
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
