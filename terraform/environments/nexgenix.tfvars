### Global Settings ####

auth_subscription_id = "##{auth_subscription_id}##"
environment  = "nexgenix"
# Root Management Group Name
root_management_group_name = "nexgenix"


### Managementgroup Values

############## Management Groups Variables ###############
layer1_management_group_names = {
  nxgl-mg-infrastructure  = {}
  nxgl-mg-landingzones    = {}
  nxgl-mg-sandbox         = {
    subscription_ids = ["##{nxglsbxsub_ID}##"]
  }
  nxgl-mg-decomissioned   = {}
}

layer2_management_group_names = {
  nxgl-mg-corp = {
    parent_management_group = "nxgl-mg-landingzones"
  }
  nxgl-mg-connectivty = {
    parent_management_group = "nxgl-mg-infrastructure"
    subscription_ids = ["##{nxglhubsub_ID}##"]
 
  }
  nxgl-mg-identity = {
    parent_management_group = "nxgl-mg-infrastructure"
    subscription_ids = ["##{nxgliamsub_ID}##"]

  }
  nxgl-mg-management = {
    parent_management_group = "nxgl-mg-infrastructure"
    subscription_ids = ["##{nxglmgmtsub_ID}##"]

  }
  nxgl-mg-engplatform = {
    parent_management_group = "nxgl-mg-infrastructure"
    subscription_ids = ["##{nxglengplatformsub_ID}##"]

  }
  nxgl-mg-cloudautomations = {
    parent_management_group = "nxgl-mg-infrastructure"
    subscription_ids = ["##{nxglcloudautosub_ID}##"]

  }  
  nxgl-mg-endusercomputing = {
    parent_management_group = "nxgl-mg-infrastructure"
    subscription_ids = ["##{nxgleucsub_ID}##"]

  }
  
}

layer3_management_group_names = {
  nxgl-mg-enterpriseops = {
    parent_management_group = "nxgl-mg-corp"
    subscription_ids = ["##{nxgleopspsub_ID}##", "##{nxgleopsnpsub_ID}##"] 

  }
  nxgl-mg-dataops = {
    parent_management_group = "nxgl-mg-corp"
    subscription_ids = ["##{nxgldataopspsub_ID}##", "##{nxgldataopsnpsub_ID}##"] 

  }

  nxgl-mg-careservices = {
    parent_management_group = "nxgl-mg-corp"
    subscription_ids = ["##{nxglcspsub_ID}##", "##{nxglcsnpsub_ID}##"]

  }
  nxgl-mg-busops = {
    parent_management_group = "nxgl-mg-corp"
    subscription_ids = ["##{nxglbusopspsub_ID}##", "##{nxglbusopsnpsub_ID}##"]
  }
  
}
################## END of Management Group Variables #################


# ### Provider settings for subscriptions

subscription_settings = {
  ## iamprdcus
  nxgliamprd = {
    subscription_name = "nxgliamsub"
    env               = "prd"
    subscription_id   = "##{nxgliamsub_ID}##"
    #subscription_id = ""
    root_id         = "nxgl"
    cidr            = ""
    region          = "centralus"
    workload        = "iam"
  }


  ## mgmt prd cus 
  nxglmgmtprd = {
    subscription_name = "nxglmgmtcus"
    env               = "prd"
    subscription_id   = "##{nxglmgmtsub_ID}##"
    #subscription_id = ""
    root_id         = "nxgl"
    cidr            = ""
    region          = "centralus"
    workload        = "mgmt"
  }
 }

# ===========================================
# Identity Module values
# ===========================================
identity_settings = {
  location         = "centralus"
  resource_group   = "nxgl-cus-managedidentity-rg"
  identity_name    = "techservices-terraform-identity"
  assignment_scope = "" # ← Will be overridden in main.tf using output from management_groups
}

# ########################
# # 📊 Log Analytics Workspace
# # ########################
loganalytics_workspaces = {
  centralus = {
    prd = {
      resource_group_name         = "nxgl-cus-mgmt-prd-loganalyticsworkspace-rg"
      location                    = "centralus"
      loganalytics_workspace_name = "nxgl-cus-prd-loganalyticsworkspace"
      automation_account_name     = "nxgl-cus-prd-lawauto"
      primestorage_account        = "nxglcuspworkspacesa"
      sku                         = "PerGB2018"
      account_tier                = "Standard"
      account_replication_type    = "GRS"
      move_cool_tier              = 90
      move_archive_tier           = 100
      delete_after_modification   = 90
      delete_snapshot             = 90
      retention_in_days           = 30
    }
    nonprd = {
      resource_group_name         = "nxgl-cus-mgmt-np-loganalyticsworkspace-rg"
      location                    = "centralus"
      loganalytics_workspace_name = "nxgl-cus-np-loganalyticsworkspace"
      automation_account_name     = "nxgl-cus-np-lawauto"
      primestorage_account        = "nxglcusnpworkspacesa"
      sku                         = "PerGB2018"
      account_tier                = "Standard"
      account_replication_type    = "LRS"
      move_cool_tier              = 30
      move_archive_tier           = 45
      delete_after_modification   = 60
      delete_snapshot             = 30
      retention_in_days           = 30
    }
  }

  westus2 = {
    prd = {
      resource_group_name         = "nxgl-wus2-mgmt-prd-loganalyticsworkspace-rg"
      location                    = "westus2"
      loganalytics_workspace_name = "nxgl-wus2-prd-loganalyticsworkspace"
      automation_account_name     = "nxgl-wus2-prd-lawauto"
      primestorage_account        = "nxglwus2pworkspacesa"
      sku                         = "PerGB2018"
      account_tier                = "Standard"
      account_replication_type    = "GRS"
      move_cool_tier              = 14
      move_archive_tier           = 21
      delete_after_modification   = 45
      delete_snapshot             = 45
      retention_in_days           = 30
    }
    nonprd = {
      resource_group_name         = "nxgl-wus2-mgmt-np-loganalyticsworkspace-rg"
      location                    = "westus2"
      loganalytics_workspace_name = "nxgl-wus2-np-loganalyticsworkspace"
      automation_account_name     = "nxgl-wus2-np-lawauto"
      primestorage_account        = "nxglwus2npworkspacesa"
      sku                         = "PerGB2018"
      account_tier                = "Standard"
      account_replication_type    = "GRS"
      move_cool_tier              = 30
      move_archive_tier           = 45
      delete_after_modification   = 60
      delete_snapshot             = 30
      retention_in_days           = 30
    }
  }
}

enable_solutions   = true
enable_data_export = false

export_tables = [
  "AzureActivity",
  "SecurityEvent",
  "Heartbeat"
]

loganalytics_tags = {
  bu                = "TechServices"
  env               = "prd"
  project           = "cloud-foundation"
  ownername         = "nxglalerts@domain.com"
  tier              = "core"
  purpose           = "central-logs"
  costcenter        = "nxgl123"
  operationalhours  = "24x7"
  security          = "NA"
  phidata           = "No"
  backup            = "No"
  disasterrecovery  = "No"
  datecreated       = "2025-06-10"
}

### Values for policies module


# 👤 Subscriptions where policies apply
######################################
subscription_policies = [
  "##{nxglhubsub_ID}##", 
  "##{nxgliamsub_ID}##",
  "##{nxglmgmtsub_ID}##",
  "##{nxglcloudautosub_ID}##", 
  "##{nxglengplatformsub_ID}##",
  "##{nxgleucsub_ID}##",
  "##{nxglsbxsub_ID}##",
  "##{nxgleopspsub_ID}##",
  "##{nxgleopsnpsub_ID}##",
  "##{nxglcspsub_ID}##",
  "##{nxglcsnpsub_ID}##",
  "##{nxgldataopspsub_ID}##",
  "##{nxgldataopsnpsub_ID}##",
  "##{nxglbusopspsub_ID}##", 
  "##{nxglbusopsnpsub_ID}##"
 
]

# 🔁 Enforcement mode per environment
######################################
enforcement_phases = {
  prd  = "AuditIfNotExists"
  dev  = "DeployIfNotExists"
  stg  = "DeployIfNotExists"
  test = "DeployIfNotExists"
  qa   = "DeployIfNotExists"
  uvm  = "DeployIfNotExists"
  sbx  = "DeployIfNotExists"
  nonprd  = "DeployIfNotExists"
}

# 🌍 Region short names for naming
######################################
regions_short = {
  centralus = "cus"
  westus2   = "wus2"
}

allowed_vm_skus = [
  "Standard_D2s_v5",
  "Standard_D4s_v5",
  "Standard_D8s_v5",
  "Standard_D16s_v5",
  "Standard_D2s_v4",
  "Standard_D4s_v4",
  "Standard_D8s_v4",
  "Standard_D16s_v4",
  "Standard_E4s_v5",
  "Standard_E8s_v5",
  "Standard_E8s_v5",
  "Standard_E16s_v5",
  "Standard_E4s_v4",
  "Standard_E8s_v4",
  "Standard_E8s_v4",
  "Standard_E16s_v4",
  "Standard_DC2s_v2",
  "Standard_DC4s_v2",
  "Standard_E2as_v5",
  "Standard_E4as_v5"
]

# ######
# # # Deny Public IP modules values  - add subscriptions to disable public IPs
# # #########
# spoke_subscription_ids = {
#   "ipgcss"   = "##{ipgcssub_ID}##"
#   "ipgeops"  = "##{ipgeopssub_ID}##"
#   "ipgmgmt"  = "##{ipgmgmtsub_ID}##"
#   "ipgiam"   = "##{ipgiamsub_ID}##"
# }


# # ##################################
# # # 💾 Backup Vaults Configuration
# # ##################################

# # environments = {
# #   dev = {
# #     location          = "Central US"
# #     vault_rg_name     = "backup-dev-rg"
# #     vault_rg_location = "Central US"
# #     vault_name        = "rsv-dev"
# #     environment       = "dev"
# #     bu                = "eops"
# #     costcenter        = "eops"
# #     owner             = "devops-team@company.com"
# #     purpose           = "backup-dr"
# #     backup            = "Yes"
# #     disasterRecovery  = "No"
# #     projectname       = "core-platform"
# #     daily_retention   = 14
# #     weekly_retention  = 4
# #     monthly_retention = 1
# #     yearly_retention  = 0
# #   }
# #   qa = {
# #     location          = "Central US"
# #     vault_rg_name     = "backup-qa-rg"
# #     vault_rg_location = "Central US"
# #     vault_name        = "rsv-qa"
# #     environment       = "qa"
# #     bu                = "eops"
# #     costcenter        = "eops"
# #     owner             = "qa-team@company.com"
# #     purpose           = "backup-dr"
# #     backup            = "Yes"
# #     disasterRecovery  = "No"
# #     projectname       = "core-platform"
# #     daily_retention   = 14
# #     weekly_retention  = 4
# #     monthly_retention = 1
# #     yearly_retention  = 0
# #   }
# #   stg = {
# #     location          = "Central US"
# #     vault_rg_name     = "backup-stg-rg"
# #     vault_rg_location = "Central US"
# #     vault_name        = "rsv-stg"
# #     environment       = "stg"
# #     bu                = "eops"
# #     costcenter        = "eops"
# #     owner             = "stg-team@company.com"
# #     purpose           = "backup-dr"
# #     backup            = "Yes"
# #     disasterRecovery  = "No"
# #     projectname       = "core-platform"
# #     daily_retention   = 14
# #     weekly_retention  = 4
# #     monthly_retention = 1
# #     yearly_retention  = 0
# #   }
# #   prd = {
# #     location          = "Central US"
# #     vault_rg_name     = "backup-prd-rg"
# #     vault_rg_location = "Central US"
# #     vault_name        = "rsv-prd"
# #     environment       = "prd"
# #     bu                = "eops"
# #     costcenter        = "eops"
# #     owner             = "prod-team@company.com"
# #     purpose           = "backup-dr"
# #     backup            = "Yes"
# #     disasterRecovery  = "Yes"
# #     projectname       = "core-platform"
# #     daily_retention   = 35
# #     weekly_retention  = 8
# #     monthly_retention = 12
# #     yearly_retention  = 7
# #   }
# # }


# # ##################################
# # # 🛡️ Backup Vault Policy Mapping
# # ##################################

# # backup_mapping = {
# #   dev = {
# #     vault_name       = module.backupvaults["dev"].vault_name
# #     backup_policy_id = module.backupvaults["dev"].backup_policy_id
# #   }
# #   qa = {
# #     vault_name       = module.backupvaults["qa"].vault_name
# #     backup_policy_id = module.backupvaults["qa"].backup_policy_id
# #   }
# #   stg = {
# #     vault_name       = module.backupvaults["stg"].vault_name
# #     backup_policy_id = module.backupvaults["stg"].backup_policy_id
# #   }
# #   prd = {
# #     vault_name       = module.backupvaults["prd"].vault_name
# #     backup_policy_id = module.backupvaults["prd"].backup_policy_id
# #   }
# # }


# # #################################
# # # 🔵 ASR Vault Settings
# # #################################

# # asr_vault_name     = "asrvault-centralus-prd"
# # dr_rg_name         = "asr-rg-centralus-prd"
# # dr_rg_location     = "Central US"
# # dr_target_location = "West US 2"

# # #################################
# # # 🔵 Target Resource Group
# # #################################

# # target_resource_group_id = "/subscriptions/af3c0053-b798-4162-bd26-0046ac7996de/resourceGroups/asr-target-rg-prd"

# # #################################
# # # 🔵 Tags and Metadata
# # #################################

# # environment      = "prd"
# # bu               = "eops"
# # costcenter       = "eops"
# # owner            = "prod-team@company.com"
# # purpose          = "disaster-recovery"
# # backup           = "Yes"
# # disasterRecovery = "Yes"
# # projectname      = "core-platform"

# # location = "central us"
