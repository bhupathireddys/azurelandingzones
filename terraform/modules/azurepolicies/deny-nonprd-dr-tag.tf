resource "azurerm_policy_definition" "deny_nonprd_dr_tag" {
  name                = "deny-dr-tag-on-nonprd"
  policy_type         = "Custom"
  mode                = "Indexed"
  management_group_id = var.management_group_id
  display_name        = "Deny DR=Yes on non-production environments"
  description         = "Prevents setting DR=Yes tag outside of PRD"

  policy_rule = jsonencode({
    "if": {
      "allOf": [
        {
          "field": "tags['disasterrecovery']",
          "equals": "Yes"
        },
        {
          "not": {
            "field": "tags['env']",
            "equals": "prd"
          }
        }
      ]
    },
    "then": {
      "effect": "deny"
    }
  })

  metadata = jsonencode({ category = "Tags" })
}
