# resource "azurerm_resource_group" "vault_rg" {
#   name     = var.vault_rg_name
#   location = var.vault_rg_location
# }

# resource "azurerm_recovery_services_vault" "backup_vault" {
#   name                          = var.vault_name
#   location                      = var.location
#   resource_group_name           = azurerm_resource_group.vault_rg.name
#   sku                           = "Standard"
#   soft_delete_enabled           = true
#   immutability                  = "Unlocked"
#   cross_region_restore_enabled = var.environment == "prd" ? true : false

#   tags = {
#     bu                = var.bu
#     env               = var.environment
#     project           = var.projectname
#     ownername         = var.owner
#     purpose           = var.purpose
#     costcenter        = var.costcenter
#     backup            = var.backup
#     disasterrecovery  = var.disasterRecovery
#   }
# }

# resource "azurerm_backup_policy_vm" "daily" {
#   name                = "daily-backup-policy-${var.environment}"
#   resource_group_name = azurerm_resource_group.vault_rg.name
#   recovery_vault_name = azurerm_recovery_services_vault.backup_vault.name

#   timezone = "UTC"

#   backup {
#     frequency = "Daily"
#     time      = "23:00"
#   }

#   retention_daily {
#     count = var.daily_retention
#   }

#   retention_weekly {
#     count    = var.weekly_retention
#     weekdays = ["Sunday"]
#   }

#   retention_monthly {
#     count    = var.monthly_retention
#     weekdays = ["Sunday"]
#     weeks    = ["First"]
#   }

#   retention_yearly {
#     count    = var.yearly_retention
#     weekdays = ["Sunday"]
#     weeks    = ["First"]
#     months   = ["January"]
#   }
# }

resource "azurerm_resource_group" "vault_rg" {
  name     = var.vault_rg_name
  location = var.vault_rg_location
}

resource "azurerm_recovery_services_vault" "backup_vault" {
  name                          = var.vault_name
  location                      = var.location
  resource_group_name           = azurerm_resource_group.vault_rg.name
  sku                           = "Standard"
  soft_delete_enabled           = true
  immutability                  = var.environment == "prd" ? "Locked" : "Unlocked"
  cross_region_restore_enabled = var.environment == "prd" ? true : false

  tags = {
    bu                = var.bu
    env               = var.environment
    project           = var.projectname
    ownername         = var.owner
    purpose           = var.purpose
    costcenter        = var.costcenter
    backup            = var.backup
    disasterrecovery  = var.disasterRecovery
  }
}

resource "azurerm_backup_policy_vm" "daily" {
  name                = "daily-backup-policy-${var.environment}"
  resource_group_name = azurerm_resource_group.vault_rg.name
  recovery_vault_name = azurerm_recovery_services_vault.backup_vault.name

  timezone = "UTC"

  backup {
    frequency = "Daily"
    time      = "23:00"
  }

  retention_daily {
    count = var.daily_retention
  }

  retention_weekly {
    count    = var.weekly_retention
    weekdays = ["Sunday"]
  }

  retention_monthly {
    count    = var.monthly_retention
    weekdays = ["Sunday"]
    weeks    = ["First"]
  }

  dynamic "retention_yearly" {
    for_each = var.yearly_retention > 0 ? [1] : []

    content {
      count    = var.yearly_retention
      weekdays = ["Sunday"]
      weeks    = ["First"]
      months   = ["January"]
    }
  }
}
