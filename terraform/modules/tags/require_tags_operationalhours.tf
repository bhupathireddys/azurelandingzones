resource "azurerm_policy_definition" "require_tag_operationalhours" {
  name                = "require-tag-operationalhours"
  policy_type         = "Custom"
  mode                = "Indexed"
  #management_group_id = var.management_group_id
  management_group_id = var.tag_settings.management_group_id
  display_name        = "Require 'operationalhours' tag on schedule-sensitive resources"
  description         = "Audit or deny if 'operationalhours' tag is missing on operationally managed Azure resources"

  policy_rule = jsonencode({
    "if": {
      "allOf": [
        {
          "field": "type",
          "in": [
            "Microsoft.Compute/virtualMachines",
            "Microsoft.Compute/virtualMachineScaleSets",
            "Microsoft.Web/sites",
            "Microsoft.Web/serverfarms",
            "Microsoft.Automation/automationAccounts"
          ]
        },
        {
          "field": "tags.operationalhours",
          "exists": "false"
        }
      ]
    },
    "then": {
      "effect": "[parameters('effect')]",
      "details": {
        "type": "Microsoft.Resources/tags",
        "existenceCondition": {
          "field": "tags.operationalhours",
          "exists": "true"
        }
      }
    }
  })

  parameters = jsonencode({
    effect = {
      type          = "String",
      allowedValues = ["AuditIfNotExists", "Deny"],
      defaultValue        = var.tag_settings.policy_effect
    }
  })

  metadata = jsonencode({ category = "Tags" })
}
