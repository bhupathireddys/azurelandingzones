resource "azurerm_policy_definition" "deny_rdp_ssh_from_internet" {
  name         = "deny-rdp-ssh-internet"
  policy_type  = "Custom"
  mode         = "All"
  display_name = "Deny RDP or SSH from Internet"
  description  = "Prevents RDP (3389) or SSH (22) access from public networks."

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
              "field": "Microsoft.Network/networkSecurityGroups/securityRules[*].destinationPortRange",
              "in": ["22", "3389"]
            },
            {
              "field": "Microsoft.Network/networkSecurityGroups/securityRules[*].destinationPortRanges[*]",
              "in": ["22", "3389"]
            }
          ]
        },
        {
          "field": "Microsoft.Network/networkSecurityGroups/securityRules[*].sourceAddressPrefix",
          "equals": "*"
        }
      ]
    },
    "then": {
      "effect": "deny"
    }
  })
  management_group_id = var.management_group_id
}


resource "azurerm_management_group_policy_assignment" "deny_rdp_ssh_from_internet" {
  name                 = "deny-rdp-ssh-internet"
  display_name         = "Deny RDP or SSH from Internet"
  policy_definition_id = azurerm_policy_definition.deny_rdp_ssh_from_internet.id
  management_group_id  = var.management_group_id
}
