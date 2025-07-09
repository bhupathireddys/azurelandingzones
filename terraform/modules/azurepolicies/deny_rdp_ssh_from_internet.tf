resource "azurerm_policy_definition" "deny_rdp_ssh_from_internet" {
  name         = "audit-rdp-ssh-internet"
  policy_type  = "Custom"
  mode         = "All"
  display_name = "Audit RDP or SSH from Internet"
  description  = "Audits any NSG allowing RDP (3389) or SSH (22) access from Internet (source *)."
  management_group_id = var.management_group_id

  policy_rule = jsonencode({
    "if": {
      "field": "type",
      "equals": "Microsoft.Network/networkSecurityGroups"
    },
    "then": {
      "effect": "auditIfNotExists",
      "details": {
        "type": "Microsoft.Network/networkSecurityGroups/securityRules",
        "existenceCondition": {
          "allOf": [
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
              "anyOf": [
                {
                  "field": "Microsoft.Network/networkSecurityGroups/securityRules[*].sourceAddressPrefix",
                  "equals": "*"
                },
                {
                  "field": "Microsoft.Network/networkSecurityGroups/securityRules[*].sourceAddressPrefixes[*]",
                  "equals": "*"
                }
              ]
            }
          ]
        }
      }
    }
  })
}

resource "azurerm_management_group_policy_assignment" "deny_rdp_ssh_from_internet" {
  name                 = "audit-rdp-ssh-internet"
  display_name         = "Audit RDP or SSH from Internet"
  policy_definition_id = azurerm_policy_definition.deny_rdp_ssh_from_internet.id
  management_group_id  = var.management_group_id
  location             = var.policy_uami_location

  identity {
    type         = "UserAssigned"
    identity_ids = [var.policy_uami_id]
  }

  non_compliance_message {
    content = "NSGs should not expose port 22 (SSH) or 3389 (RDP) to the Internet (source '*'). Use Bastion, VPN, or JIT."
  }

  depends_on = [azurerm_policy_definition.deny_rdp_ssh_from_internet]
}
