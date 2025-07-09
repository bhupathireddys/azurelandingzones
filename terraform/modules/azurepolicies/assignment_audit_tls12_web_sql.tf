resource "azurerm_policy_definition" "enforce_tls12_appservice" {
  name         = "enforce-tls12-appservice"
  display_name = "Enforce Minimum TLS 1.2 or Higher for App Services"
  policy_type  = "Custom"
  mode         = "Indexed"
  description  = "Enforces that App Services use a minimum of TLS 1.2 or higher (1.3 allowed)."

  policy_rule = jsonencode({
    "if": {
      "field": "type",
      "equals": "Microsoft.Web/sites"
    },
    "then": {
      "effect": "deployIfNotExists",
      "details": {
        "type": "Microsoft.Web/sites/config",
        "name": "web",
        "existenceCondition": {
          "anyOf": [
            {
              "field": "Microsoft.Web/sites/config/minTlsVersion",
              "equals": "1.2"
            },
            {
              "field": "Microsoft.Web/sites/config/minTlsVersion",
              "equals": "1.3"
            }
          ]
        },
        "roleDefinitionIds": [
          "/providers/microsoft.authorization/roleDefinitions/b24988ac-6180-42a0-ab88-20f7382dd24c" # Contributor
        ],
        "deployment": {
          "properties": {
            "mode": "incremental",
            "template": {
              "$schema": "https://schema.management.azure.com/schemas/2018-05-01/subscriptionDeploymentTemplate.json#",
              "contentVersion": "1.0.0.0",
              "resources": [
                {
                  "type": "Microsoft.Web/sites/config",
                  "apiVersion": "2022-03-01",
                  "name": "[concat(field('name'), '/web')]",
                  "properties": {
                    "minTlsVersion": "1.2"
                  }
                }
              ]
            },
            "parameters": {}
          }
        }
      }
    }
  })

  metadata = jsonencode({
    category = "Security"
  })

  management_group_id = var.management_group_id
}

resource "azurerm_management_group_policy_assignment" "enforce_tls12_appservice" {
  name                 = "enforce-tls12-appservice"
  display_name         = "Enforce Minimum TLS 1.2 or Higher for App Services"
  policy_definition_id = azurerm_policy_definition.enforce_tls12_appservice.id
  management_group_id  = var.management_group_id
  location             = var.policy_uami_location
  enforce              = true

  identity {
    type         = "UserAssigned"
    identity_ids = [var.policy_uami_id]
  }

  non_compliance_message {
    content = "App Services must enforce TLS version 1.2 or higher."
  }

  depends_on = [
    azurerm_policy_definition.enforce_tls12_appservice
  ]
}
