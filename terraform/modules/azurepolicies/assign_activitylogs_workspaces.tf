# resource "azurerm_subscription_policy_assignment" "activitylogs_nonprd" {
#   for_each             = var.nonprod_subscription_info
#   name                 = "activitylogs-nonprd-${replace(each.key, "-", "")}"
#   display_name         = "Assign activity logs policy - nonprd"
#   policy_definition_id = azurerm_policy_definition.sub_activity_laws.id
#   subscription_id      = "/subscriptions/${each.key}"
#   location             = each.value.region
#   enforce              = true

#   parameters = jsonencode({
#     logAnalyticsWorkspaceId = {
#       value = var.workspace_ids["${each.value.region}-${each.value.env}"]
#     },
#     logsEnabled = {
#       value = "true"
#     },
#     logsRetentionDays = {
#       value = var.loganalytics_workspaces[each.value.region].nonprd.retention_in_days
#     },
#     location = {
#       value = each.value.region
#     },
#     effect = {
#       value = "DeployIfNotExists"
#     }
#   })

#   identity {
#     type         = "UserAssigned"
#     identity_ids = [var.policy_uami_id]
#   }

#   non_compliance_message {
#     content = "Activity logs must be forwarded to the nonprod LAW."
#   }

#   depends_on = [azurerm_policy_definition.sub_activity_laws]
# }

# resource "azurerm_subscription_policy_assignment" "activitylogs_prd" {
#   for_each             = var.prod_subscription_info
#   name                 = "activitylogs-prd-${replace(each.key, "-", "")}"
#   display_name         = "Assign activity logs policy - prod"
#   policy_definition_id = azurerm_policy_definition.sub_activity_laws.id
#   subscription_id      = "/subscriptions/${each.key}"
#   location             = each.value.region
#   enforce              = true

#   parameters = jsonencode({
#     logAnalyticsWorkspaceId = {
#       value = var.workspace_ids["${each.value.region}-${each.value.env}"]
#     },
#     logsEnabled = {
#       value = "true"
#     },
#     logsRetentionDays = {
#       value = var.loganalytics_workspaces[each.value.region].prd.retention_in_days
#     },
#     location = {
#       value = each.value.region
#     },
#     effect = {
#       value = "DeployIfNotExists"
#     }
#   })

#   identity {
#     type         = "UserAssigned"
#     identity_ids = [var.policy_uami_id]
#   }

#   non_compliance_message {
#     content = "Activity logs must be forwarded to the prod LAW."
#   }

#   depends_on = [azurerm_policy_definition.sub_activity_laws]
# }
