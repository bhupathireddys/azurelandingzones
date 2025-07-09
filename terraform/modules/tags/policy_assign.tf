resource "azurerm_management_group_policy_assignment" "assign_tagging_initiative" {
  name                 = "mandatory-tags-assign"
  display_name         = "Mandatory Tagging Policy Assignment"
  policy_definition_id = azurerm_policy_set_definition.tagging_initiative.id
  management_group_id = var.tag_settings.management_group_id
  location             = var.tag_settings.identity_location
  enforce              = true

  identity {
    type         = "UserAssigned"
    identity_ids        = [var.tag_settings.policy_uami_id]
  }

  non_compliance_message {
    content = "This resource must include all mandatory tags or it will be denied."
  }

  depends_on = [
    azurerm_policy_set_definition.tagging_initiative
  ]
}
