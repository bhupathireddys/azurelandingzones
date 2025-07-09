resource "azurerm_policy_definition" "require_tag_projectname" {
  name                = "require-tag-project"
  policy_type         = "Custom"
  mode                = "Indexed"
  #management_group_id = var.management_group_id
  management_group_id = var.tag_settings.management_group_id
  display_name        = "Require 'project' tag on applicable Azure resources"
  description         = "Audit or deny if 'project' tag is missing on key infrastructure and data resources"

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
            "Microsoft.KeyVault/vaults",
            "Microsoft.Storage/storageAccounts",
            "Microsoft.Resources/resourceGroups",
            "Microsoft.Automation/automationAccounts",
            "Microsoft.DataFactory/factories",
            "Microsoft.Databricks/workspaces",
            "Microsoft.RecoveryServices/vaults",
            "Microsoft.Synapse/workspaces"
          ]
        },
        {
          "field": "tags.project",
          "exists": "false"
        }
      ]
    },
    "then": {
      "effect": "[parameters('effect')]",
      "details": {
        "type": "Microsoft.Resources/tags",
        "existenceCondition": {
          "field": "tags.project",
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
