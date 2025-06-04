resource "azurerm_management_group_policy_assignment" "diagnosticsettings_global" {
  name                 = "mg-diagnostics-global"
  display_name         = "Assign diagnostic settings policy for critical Azure services"
  description          = "Ensure diagnostic settings are enabled and logs are forwarded to Log Analytics Workspace"
  policy_definition_id = azurerm_policy_definition.enable_diagnostic_settings.id
  management_group_id  = var.management_group_id
  location             = var.location
  enforce              = true

  parameters = jsonencode({
    logAnalyticsWorkspaceId = {
      value = var.primary_law_id
    },
    logsRetentionPolicyEnabled = {
      value = true
    },
    logsRetentionDays = {
      value = var.log_retention_in_days
    },
    metricsRetentionPolicyEnabled = {
      value = true
    },
    metricsRetentionDays = {
      value = var.log_retention_in_days
    }
  })

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.policy_uami.id]
  }

  non_compliance_message {
    content = "All critical resources must have diagnostics configured and logs forwarded to central LAW."
  }

  depends_on = [
    azurerm_user_assigned_identity.policy_uami,
    azurerm_policy_definition.enable_diagnostic_settings
  ]
}
