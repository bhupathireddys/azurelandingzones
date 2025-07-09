# ### File: modules/azurepolicies/activitylogs-to-workspace.tf
# resource "azurerm_policy_definition" "sub_activity_laws" {
#   name         = "enable-activitylogs-subscriptions"
#   policy_type  = "Custom"
#   mode         = "Indexed"
#   display_name = "Enable activity logs for subscriptions"
#   description  = "Deploys diagnostic settings to push Activity Logs to Log Analytics workspace"

#   policy_rule = file("${path.module}/policy-defs/activitylogs-to-workspace.json")

#   parameters = jsonencode({
#     logAnalyticsWorkspaceId = {
#       type     = "String"
#       metadata = {
#         description = "The resource ID of the Log Analytics workspace"
#         displayName = "Log Analytics Workspace ID"
#       }
#     },
#     logsEnabled = {
#       type         = "String"
#       defaultValue = "true"
#       metadata     = {
#         description = "Enable Activity Logs"
#         displayName = "Enable Logs"
#       }
#     },
#     logsRetentionDays = {
#       type         = "Integer"
#       defaultValue = 30
#       metadata     = {
#         description = "Retention in days"
#         displayName = "Log Retention Days"
#       }
#     },
#     location = {
#       type         = "String"
#       defaultValue = "centralus"
#       metadata     = {
#         description = "Region for deployment"
#         displayName = "Location"
#       }
#     },
#     effect = {
#       type          = "String"
#       allowedValues = ["DeployIfNotExists", "AuditIfNotExists", "Disabled"]
#       defaultValue  = "DeployIfNotExists"
#       metadata      = {
#         description = "The effect of the policy"
#         displayName = "Effect"
#       }
#     }
#   })

#   management_group_id = var.management_group_id
# }
