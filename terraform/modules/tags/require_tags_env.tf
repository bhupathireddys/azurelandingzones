resource "azurerm_policy_definition" "require_tag_env" {
  name                = "require-tag-env"
  policy_type         = "Custom"
  mode                = "Indexed"
  #management_group_id = var.management_group_id
  management_group_id = var.tag_settings.management_group_id
  display_name        = "Require and validate 'env' tag on key Azure resources"
  description         = "Audit or deny if 'env' tag is missing or invalid. Allowed values: prd, dev, qa, stg"

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
            "Microsoft.Sql/servers",
            "Microsoft.Sql/managedInstances",
            "Microsoft.KeyVault/vaults",
            "Microsoft.Storage/storageAccounts",
            "Microsoft.Resources/resourceGroups",
            "Microsoft.OperationalInsights/workspaces",
            "Microsoft.Automation/automationAccounts",
            "Microsoft.DataFactory/factories",
            "Microsoft.Databricks/workspaces",
            "Microsoft.RecoveryServices/vaults",
            "Microsoft.ContainerService/managedClusters",
            "Microsoft.Network/applicationGateways",
            "Microsoft.Network/loadBalancers",
            "Microsoft.Network/virtualNetworks",
            "Microsoft.Synapse/workspaces"
          ]
        },
        {
          "anyOf": [
            { "field": "tags.env", "exists": "false" },
            { "field": "tags.env", "notIn": "[parameters('allowedValues')]" }
          ]
        }
      ]
    },
    "then": {
      "effect": "[parameters('effect')]",
      "details": {
        "type": "Microsoft.Resources/tags",
        "existenceCondition": {
          "allOf": [
            { "field": "tags.env", "in": "[parameters('allowedValues')]" }
          ]
        }
      }
    }
  })

  parameters = jsonencode({
    allowedValues = {
      type          = "Array",
      defaultValue  = ["prd", "dev", "qa", "stg", "sbx", "euvm"],
      metadata = {
        displayName = "Allowed Environment Values",
        description = "Only these values are allowed: prd, dev, qa, stg, euvm, sbx"
      }
    },
    effect = {
      type          = "String",
      allowedValues = ["AuditIfNotExists", "Deny"],
      defaultValue        = "Deny"
    }
  })

  metadata = jsonencode({ category = "Tags" })
}
