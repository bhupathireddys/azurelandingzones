# ---- initiatives.tf ----
resource "azurerm_policy_set_definition" "tagging_initiative" {
  name                 = "mandatory-tagging-policy-initiative"
  policy_type          = "Custom"
  management_group_id  = var.management_group_id
  display_name         = "Mandatory Tagging Policy Initiative"
  description          = "Initiative to enforce tagging standards across key resources."

  policy_definition_reference {
    policy_definition_id = azurerm_policy_definition.require_tag_bu.id
    parameter_values     = jsonencode({ effect = { value = var.policy_effect } })
  }

  policy_definition_reference {
    policy_definition_id = azurerm_policy_definition.require_tag_costcenter.id
    parameter_values     = jsonencode({ effect = { value = var.policy_effect } })
  }

  policy_definition_reference {
    policy_definition_id = azurerm_policy_definition.require_tag_projectname.id
    parameter_values     = jsonencode({ effect = { value = var.policy_effect } })
  }

  policy_definition_reference {
    policy_definition_id = azurerm_policy_definition.require_tag_ownername.id
    parameter_values     = jsonencode({ effect = { value = var.policy_effect } })
  }

  policy_definition_reference {
    policy_definition_id = azurerm_policy_definition.require_tag_operationalhours.id
    parameter_values     = jsonencode({ effect = { value = var.policy_effect } })
  }

  policy_definition_reference {
    policy_definition_id = azurerm_policy_definition.require_tag_purpose.id
    parameter_values     = jsonencode({ effect = { value = var.policy_effect } })
  }

  policy_definition_reference {
    policy_definition_id = azurerm_policy_definition.require_tag_tier.id
    parameter_values     = jsonencode({ effect = { value = var.policy_effect } })
  }

  metadata = jsonencode({
    category = "Tags"
  })
}
