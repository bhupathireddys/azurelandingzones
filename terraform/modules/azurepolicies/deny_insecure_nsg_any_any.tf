resource "azurerm_policy_definition" "deny_insecure_nsg_any_any" {
  name         = "deny-nsg-any-any"
  policy_type  = "Custom"
  mode         = "All"
  display_name = "Deny Insecure NSG Rules (Any-Any)"
  description  = "Denies NSG rules that allow unrestricted source and destination."

  policy_rule = jsonencode({
    "if": {
      "allOf": [
        {
          "field": "type",
          "equals": "Microsoft.Network/networkSecurityGroups"
        },
        {
          "anyOf": [
            {
              "field": "Microsoft.Network/networkSecurityGroups/securityRules[*].sourceAddressPrefix",
              "equals": "*"
            },
            {
              "field": "Microsoft.Network/networkSecurityGroups/securityRules[*].destinationAddressPrefix",
              "equals": "*"
            }
          ]
        }
      ]
    },
    "then": {
      "effect": "deny"
    }
  })

  management_group_id = var.management_group_id
}


resource "azurerm_management_group_policy_assignment" "deny_insecure_nsg_any_any" {
  name                 = "deny-nsg-any-any"
  display_name         = "Deny Insecure NSG Rules (Any-Any)"
  policy_definition_id = azurerm_policy_definition.deny_insecure_nsg_any_any.id
  management_group_id  = var.management_group_id
}
