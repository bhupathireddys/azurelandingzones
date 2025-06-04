resource "azurerm_policy_definition" "require_tag_tier" {
  name                = "require-tag-tier"
  policy_type         = "Custom"
  mode                = "Indexed"
  management_group_id = var.management_group_id
  display_name        = "Require 'tier' tag on workload-related Azure resources"
  description         = "Audit or deny if 'tier' tag is missing on app/data tier resources"

  policy_rule = jsonencode({
    "if": {
      "allOf": [
        {
          "field": "type",
          "in": [
            "Microsoft.Compute/virtualMachines",
            "Microsoft.Compute/virtualMachineScaleSets",
            "Microsoft.Web/sites",
            "Microsoft.Sql/servers",
            "Microsoft.Databricks/workspaces"
          ]
        },
        {
          "field": "tags.tier",
          "exists": "false"
        }
      ]
    },
    "then": {
      "effect": "[parameters('effect')]",
      "details": {
        "type": "Microsoft.Resources/tags",
        "existenceCondition": {
          "field": "tags.tier",
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
