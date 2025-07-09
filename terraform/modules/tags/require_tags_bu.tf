resource "azurerm_policy_definition" "require_tag_bu" {
  name         = "require-tag-bu"
  policy_type  = "Custom"
  mode         = "Indexed"
  #management_group_id = var.management_group_id
  management_group_id = var.tag_settings.management_group_id
  display_name = "Require 'bu' tag on critical business resources"
  description  = "Audit or deny if 'bu' tag is missing"

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
            "Microsoft.OperationalInsights/workspaces",
            "Microsoft.Automation/automationAccounts",
            "Microsoft.DataFactory/factories",
            "Microsoft.Databricks/workspaces",
            "Microsoft.RecoveryServices/vaults",
            "Microsoft.Web/serverfarms",
            "Microsoft.ContainerService/managedClusters",
            "Microsoft.Network/applicationGateways",
            "Microsoft.Network/loadBalancers",
            "Microsoft.Network/virtualNetworks",
            "Microsoft.Synapse/workspaces"
          ]
        },
        {
          "field": "tags.bu",
          "exists": "false"
        }
      ]
    },
    "then": {
      "effect": "[parameters('effect')]",
      "details": {
        "type": "Microsoft.Resources/tags",
        "existenceCondition": {
          "field": "tags.bu",
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
