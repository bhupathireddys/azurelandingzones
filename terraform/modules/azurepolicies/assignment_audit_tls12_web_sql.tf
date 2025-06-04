resource "azurerm_policy_definition" "enforce_tls12_appservice" {
  name         = "enforce-tls12-appservice"
  display_name = "Enforce Minimum TLS 1.2 or Higher for App Services"
  policy_type  = "Custom"
  mode         = "Indexed"
  description  = "Enforces that App Services use a minimum of TLS 1.2 or higher (1.3 allowed)"

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
            { "field": "Microsoft.Web/sites/config/minTlsVersion", "equals": "1.2" },
            { "field": "Microsoft.Web/sites/config/minTlsVersion", "equals": "1.3" }
          ]
        },
        "roleDefinitionIds": [
          "/providers/microsoft.authorization/roleDefinitions/Contributor"
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
  location = var.identity_location
  
  enforce              = true
  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.policy_uami.id]
    
  }
}


# $Tenant='682e6fb4-6d2b-4adb-b15f-8be9868df7ed';
# $ClientId='29fe2b4f-5f29-4279-8569-471fd2a25d11';
# $ServicePrincipal='2c31198c-2bad-4042-ad97-1a85a7fce420'; 
# $EmailGroupId='lanternjamfalerts@lanterncare.com'; 

 
