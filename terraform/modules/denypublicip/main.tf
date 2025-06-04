resource "azurerm_policy_definition" "deny_public_ip" {
  name                  = "deny-public-ips-in-spoke"
  policy_type           = "Custom"
  mode                  = "All"
  management_group_id   = var.management_group_id
  display_name          = "Deny Public IPs in Spoke Subscriptions"
  description           = "Restrict creation of Public IPs in spoke subscriptions."

  policy_rule = jsonencode({
    "if": {
      "field": "type",
      "equals": "Microsoft.Network/publicIPAddresses"
    },
    "then": {
      "effect": "Deny"
    }
  })
}

resource "azurerm_subscription_policy_assignment" "deny_public_ip_assignment" {
  for_each             = var.spoke_subscription_ids
  name                 = "deny-public-ip-${each.key}"
  policy_definition_id = azurerm_policy_definition.deny_public_ip.id
  subscription_id = "/subscriptions/${each.value}"
  display_name         = "Deny Public IPs - ${each.key}"
  description          = "Restricts public IPs in ${each.key} subscription"
}
