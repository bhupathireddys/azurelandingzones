resource "azurerm_policy_definition" "sub_activity_laws" {
  name         = "enable-activitylogs-subscriptions"
  policy_type  = "Custom"
  mode         = "Indexed"
  display_name = "Enable activity logs for subscriptions"
  description  = "Deploys diagnostic settings to push Activity Logs to Log Analytics workspace"

  policy_rule = file("${path.module}/activitylogs-to-workspace.json")

  parameters = jsonencode({
    logAnalyticsWorkspaceId = {
      type        = "String"
      metadata    = {
        description = "The resource ID of the Log Analytics workspace"
        displayName = "Log Analytics Workspace ID"
      }
    },
    logsEnabled = {
      type        = "String"
      metadata    = {
        description = "Enable Activity Logs"
        displayName = "Enable Logs"
      }
      defaultValue = "true"
    },
    logsRetentionDays = {
      type        = "Integer"
      metadata    = {
        description = "Retention in days"
        displayName = "Log Retention Days"
      }
      defaultValue = 365
    },
    location = {
      type        = "String"
      metadata    = {
        description = "Region for deployment"
        displayName = "Location"
      }
      defaultValue = "centralus"
    },
    effect = {
      type          = "String"
      allowedValues = ["DeployIfNotExists", "AuditIfNotExists", "Disabled"]
      defaultValue  = "DeployIfNotExists"
      metadata = {
        description = "The effect of the policy"
        displayName = "Effect"
      }
    }
  })

  management_group_id = data.azurerm_management_group.root.id
}
