resource "azurerm_policy_definition" "central_diagnostics" {
  name                = "central-diagnostics-policy"
  policy_type         = "Custom"
  mode                = "Indexed"
  display_name        = "Central Diagnostics Policy"
  description         = "Configure diagnostic settings for all supported resources with tag-based enforcement"
  management_group_id = var.management_group_id

  metadata = jsonencode({
    category = "Monitoring"
    version  = "1.0.0"
  })

  parameters = <<PARAMETERS
    {
      "workspaceId": {
        "type": "String",
        "metadata": {
          "displayName": "Log Analytics Workspace ID",
          "description": "Workspace where logs will be sent"
        }
      },
      "effect": {
        "type": "String",
        "defaultValue": "DeployIfNotExists",
        "allowedValues": [
          "DeployIfNotExists",
          "AuditIfNotExists",
          "Disabled"
        ],
        "metadata": {
          "displayName": "Effect",
          "description": "Enable or disable the execution of the policy"
        }
      },
      "resourceType": {
        "type": "String",
        "metadata": {
          "displayName": "Resource Type",
          "description": "The resource type to apply diagnostics to"
        }
      }
    }
  PARAMETERS

  policy_rule = templatefile("${path.module}/policy-defs/central_diagnostics.json", {
    resource_diagnostics = jsonencode(local.resource_diagnostics)
  })
}