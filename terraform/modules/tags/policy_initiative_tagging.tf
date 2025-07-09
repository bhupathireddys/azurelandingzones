resource "azurerm_policy_set_definition" "tagging_initiative" {
  name                 = "mandatory-tagging-policy-initiative"
  policy_type          = "Custom"
  management_group_id  = var.tag_settings.management_group_id
  display_name         = "Mandatory Tagging Policy Initiative"
  description          = "Initiative to enforce tagging standards across key resources."

  policy_definition_reference {
    policy_definition_id = azurerm_policy_definition.require_tag_bu.id
    parameter_values     = jsonencode({ effect = { value = var.tag_settings.policy_effect } })
  }

  policy_definition_reference {
    policy_definition_id = azurerm_policy_definition.require_tag_costcenter.id
    parameter_values     = jsonencode({ effect = { value = var.tag_settings.policy_effect } })
  }

  policy_definition_reference {
    policy_definition_id = azurerm_policy_definition.require_tag_projectname.id
    parameter_values     = jsonencode({ effect = { value = var.tag_settings.policy_effect } })
  }

  policy_definition_reference {
    policy_definition_id = azurerm_policy_definition.require_tag_ownername.id
    parameter_values     = jsonencode({ effect = { value = var.tag_settings.policy_effect } })
  }

  policy_definition_reference {
    policy_definition_id = azurerm_policy_definition.require_tag_operationalhours.id
    parameter_values     = jsonencode({ effect = { value = var.tag_settings.policy_effect } })
  }

  policy_definition_reference {
    policy_definition_id = azurerm_policy_definition.require_tag_purpose.id
    parameter_values     = jsonencode({ effect = { value = var.tag_settings.policy_effect } })
  }

  policy_definition_reference {
    policy_definition_id = azurerm_policy_definition.require_tag_tier.id
    parameter_values     = jsonencode({ effect = { value = var.tag_settings.policy_effect } })
  }

  # Modify-effect policy: No parameters needed
  policy_definition_reference {
    policy_definition_id = azurerm_policy_definition.require_tag_backup_disasterrecovery.id
  }

policy_definition_reference {
  policy_definition_id = azurerm_policy_definition.require_tag_phidata.id
  parameter_values     = null  # No parameters required, effect is hardcoded in policy
}
  metadata = jsonencode({
    category = "Tags"
  })
}
