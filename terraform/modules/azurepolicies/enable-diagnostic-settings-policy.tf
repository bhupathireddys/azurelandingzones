
# Policy Definition: Enable Diagnostic Settings for critical healthcare services
resource "azurerm_policy_definition" "enable_diagnostic_settings" {
  name         = "enable-diagnostic-settings"
  policy_type  = "Custom"
  mode         = "Indexed"
  display_name = "Enable diagnostic settings for critical healthcare Azure services"
  description  = "Enforces diagnostic settings with secure log retention for essential services like VMs, KeyVault, SQL, WebApps, Storage, etc."

  policy_rule = file("${path.module}/enable-diagnostic-settings-policy.json")

  parameters = jsonencode({
    logAnalyticsWorkspaceId = {
      type = "String"
      metadata = {
        description = "The resource ID of the Log Analytics Workspace to send logs."
        displayName = "Log Analytics Workspace ID"
      }
    },
    logsRetentionPolicyEnabled = {
      type = "Boolean"
      metadata = {
        description = "Enable or disable logs retention policy."
        displayName = "Logs Retention Policy Enabled"
      }
    },
    logsRetentionDays = {
      type = "Integer"
      metadata = {
        description = "Retention period in days for logs."
        displayName = "Logs Retention Days"
      }
    },
    metricsRetentionPolicyEnabled = {
      type = "Boolean"
      metadata = {
        description = "Enable or disable metrics retention policy."
        displayName = "Metrics Retention Policy Enabled"
      }
    },
    metricsRetentionDays = {
      type = "Integer"
      metadata = {
        description = "Retention period in days for metrics."
        displayName = "Metrics Retention Days"
      }
    }
  })

  # ✅ Scope is management group
  management_group_id = data.azurerm_management_group.root.id
}
