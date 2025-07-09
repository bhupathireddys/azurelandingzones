
############## Module Outputs ################
output "root_management_group_id" {
  description = "Root management group ID"
  value       = module.management_groups.root_management_group_id[var.root_management_group_name]
}

output "root_management_group_display_name" {
  description = "Root management group display name"
  value       = var.root_management_group_name
}


output "layer1_management_groups" {
  description = "Layer 1 management groups and their IDs"
  value       = module.management_groups.layer1_management_group_ids
}

output "layer2_management_groups" {
  description = "Layer 2 management groups and their IDs"
  value       = module.management_groups.layer2_management_group_ids
}

output "layer3_management_groups" {
  description = "Layer 3 management groups and their IDs"
  value       = module.management_groups.layer3_management_group_ids
}


##########################################
# Managed Identity Outputs
##########################################
output "policy_uami_id" {
  value       = module.managedidentity.policy_uami_id
  description = "ID of the managed identity"
}

output "policy_uami_client_id" {
  value       = module.managedidentity.policy_uami_client_id
  description = "Client ID of the managed identity"
}

output "policy_uami_principal_id" {
  value       = module.managedidentity.policy_uami_principal_id
  description = "Principal ID of the managed identity"
}
output "policy_uami_location" {
  description = "Location of the User Assigned Managed Identity"
  value       = module.managedidentity.policy_uami_location
}
##########################################
# Tags Module Outputs
##########################################
output "tagging_policy_assignment_id" {
  value       = module.tags.tagging_policy_assignment_id
  description = "ID of the tagging policy assignment"
}

#########################################
# 📤 Log Analytics Workspace Outputs
#########################################

output "workspace_ids" {
  description = "Log Analytics Workspace IDs per region and environment"
  value = {
    for key, mod in module.loganalyticsworkspace :
    key => mod.workspace_id
  }
}
output "workspace_customer_ids" {
  description = "Workspace Customer IDs per region and environment"
  value = {
    for key, mod in module.loganalyticsworkspace :
    key => mod.workspace_customer_id
  }
}

output "workspace_names" {
  description = "Log Analytics Workspace Names per region and environment"
  value = {
    for key, mod in module.loganalyticsworkspace :
    key => mod.workspace_name
  }
}

output "law_resource_group_names" {
  description = "Log Analytics Workspace RG names per region and environment"
  value = {
    for key, mod in module.loganalyticsworkspace :
    key => mod.law_resource_group_name
  }
}

output "automation_account_ids" {
  description = "Automation Account IDs per region and environment"
  value = {
    for key, mod in module.loganalyticsworkspace :
    key => mod.automation_account_id
  }
}

output "storage_account_ids" {
  description = "Storage Account IDs per region and environment"
  value = {
    for key, mod in module.loganalyticsworkspace :
    key => mod.storage_account_id
  }
}


output "workspace_locations" {
  value = {
    for key, mod in module.loganalyticsworkspace :
    key => mod.workspace_location
  }
}

output "region_env_keys" {
  description = "List of all region-env keys like cus-prd, wus2-nonprd"
  value       = keys(module.loganalyticsworkspace)
}

################
# Policies Modules Outputs
################

output "policy_definitions" {
  description = "All policy definition IDs created by the module"
  value       = module.azurepolicies.policy_definition_ids
}

output "policy_assignments" {
  description = "All policy assignment IDs created by the module"
  value       = module.azurepolicies.policy_assignment_ids
}


# Workspace Mappings
output "log_analytics_workspace_mappings" {
  description = "Map of region-environment to Log Analytics Workspace IDs"
  value       = local.workspace_ids
}

# Enforcement Status
output "enforcement_status" {
  description = "Map showing enforcement phases per environment"
  value       = var.enforcement_phases
}
