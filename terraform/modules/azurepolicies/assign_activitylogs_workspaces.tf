resource "azurerm_management_group_policy_assignment" "activitylogs_global" {
  name                 = "mg-auditlogs-global"
  display_name         = "Assign subscription activity logs policy"
  description          = "Enforces activity log forwarding to central Log Analytics Workspace"
  policy_definition_id = azurerm_policy_definition.sub_activity_laws.id
  management_group_id  = var.management_group_id
  location             = var.location
  enforce              = true

  parameters = jsonencode({
    logAnalyticsWorkspaceId = {
      value = var.primary_law_id
    },
    logsEnabled = {
      value = "true"
    },
    logsRetentionDays = {
      value = var.log_retention_in_days
    },
    location = {
      value = var.location
    },
    effect = {
      value = "DeployIfNotExists"
    }
  })

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.policy_uami.id]
  }

  non_compliance_message {
    content = "Activity logs must be forwarded to the central LAW for auditing."
  }

  depends_on = [
    azurerm_user_assigned_identity.policy_uami,
    azurerm_policy_definition.sub_activity_laws
  ]
}
