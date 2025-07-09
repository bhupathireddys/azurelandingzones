############ Module for managementgroups ###############

module "management_groups" {
  source = "./modules/management_groups"
  root_management_group_name    = var.root_management_group_name
  layer1_management_group_names = var.layer1_management_group_names
  layer2_management_group_names = var.layer2_management_group_names
  layer3_management_group_names = var.layer3_management_group_names
}

##########################################
# Managedidentity Module
##########################################
module "managedidentity" {
  source    = "./modules/managedidentity"
  providers = { azurerm = azurerm.iamprd }

  identity_settings = {
    location         = var.identity_settings.location
    resource_group   = var.identity_settings.resource_group
    identity_name    = var.identity_settings.identity_name
    assignment_scope =  module.management_groups.root_management_group_id[var.root_management_group_name]
  }
  depends_on = [ module.management_groups ]
}


##########################################
# Tags Module
##########################################
module "tags" {
  source    = "./modules/tags"
  providers = { azurerm = azurerm.iamprd }

  tag_settings = {
    management_group_id      = module.management_groups.root_management_group_id[var.root_management_group_name]
    policy_effect            = "AuditIfNotExists"
    identity_location        = var.identity_settings.location
    policy_uami_id           = module.managedidentity.policy_uami_id
    policy_uami_client_id    = module.managedidentity.policy_uami_client_id
    policy_uami_principal_id = module.managedidentity.policy_uami_principal_id
  }

  depends_on = [module.managedidentity]
}


# #########################################
# Log Analytics Workspace Module
#########################################

module "loganalyticsworkspace" {
  for_each = merge([
    for region, envs in var.loganalytics_workspaces : {
      for env, config in envs :
      "${region}-${env}" => {
        region = region
        env    = env
        config = config
      }
    }
  ]...)

  source    = "./modules/loganalyticsworkspace"
  providers = { azurerm = azurerm.mgmtprd }

  workspace = {
    resource_group_name         = each.value.config.resource_group_name
    location                    = each.value.config.location
    loganalytics_workspace_name = each.value.config.loganalytics_workspace_name
    automation_account_name     = each.value.config.automation_account_name
    primestorage_account        = each.value.config.primestorage_account
    sku                         = each.value.config.sku
    account_tier                = each.value.config.account_tier
    account_replication_type    = each.value.config.account_replication_type
    move_cool_tier              = each.value.config.move_cool_tier
    move_archive_tier           = each.value.config.move_archive_tier
    delete_after_modification   = each.value.config.delete_after_modification
    delete_snapshot             = each.value.config.delete_snapshot
    retention_in_days           = each.value.config.retention_in_days
  }

  log_retention_days = var.log_retention_days
  enable_solutions   = var.enable_solutions
  enable_data_export = var.enable_data_export
  export_tables      = var.export_tables
  default_tags       = var.loganalytics_tags


  depends_on = [
    module.tags,
    module.managedidentity
  ]
}


# #########################################
# # 🔐 Azure Policies Module
# #########################################

module "azurepolicies" {
  source = "./modules/azurepolicies"

  management_group_id      = module.management_groups.root_management_group_id[var.root_management_group_name]
  policy_uami_id           = module.managedidentity.policy_uami_id
  policy_uami_location     = module.managedidentity.policy_uami_location
  policy_uami_principal_id = module.managedidentity.policy_uami_principal_id

  region_env_keys          = local.region_env_keys
  workspace_ids            = local.workspace_ids
  enforcement_phases       = var.enforcement_phases
  subscription_policies    = var.subscription_policies
  regions_short            = var.regions_short 
  allowed_vm_skus          = var.allowed_vm_skus
}
