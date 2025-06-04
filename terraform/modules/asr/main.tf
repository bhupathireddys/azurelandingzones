resource "azurerm_resource_group" "asr_rg" {
  name     = var.dr_rg_name
  location = var.dr_rg_location

  tags = {
    bu               = var.bu
    env              = var.environment
    costcenter       = var.costcenter
    ownername        = var.owner
    purpose          = var.purpose
    backup           = var.backup
    disasterrecovery = var.disasterRecovery
    project          = var.projectname
  }
}

resource "azurerm_recovery_services_vault" "asr_vault" {
  name                = var.asr_vault_name
  location            = var.dr_rg_location
  resource_group_name = azurerm_resource_group.asr_rg.name
  sku                 = "Standard"

  soft_delete_enabled          = true
  cross_region_restore_enabled = true

  tags = {
    bu               = var.bu
    env              = var.environment
    costcenter       = var.costcenter
    ownername        = var.owner
    purpose          = var.purpose
    backup           = var.backup
    disasterrecovery = var.disasterRecovery
    project          = var.projectname
  }
}
