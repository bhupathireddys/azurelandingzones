##########################################
# Resource Group for LAW
##########################################
resource "azurerm_resource_group" "lawsrg" {
  name     = var.workspace.resource_group_name
  location = var.workspace.location
  tags     = var.default_tags
}

##########################################
# Log Analytics Workspace
##########################################
resource "azurerm_log_analytics_workspace" "lawspace" {
  name                = var.workspace.loganalytics_workspace_name
  location            = azurerm_resource_group.lawsrg.location
  resource_group_name = azurerm_resource_group.lawsrg.name
  sku                 = var.workspace.sku
  retention_in_days   = var.workspace.retention_in_days

  internet_ingestion_enabled = true
  internet_query_enabled     = true
  tags                       = var.default_tags
}

##########################################
# Secure Storage Account for LAW
##########################################
resource "azurerm_storage_account" "primestorage" {
  name                         = var.workspace.primestorage_account
  location                     = azurerm_resource_group.lawsrg.location
  resource_group_name          = azurerm_resource_group.lawsrg.name
  account_tier                 = var.workspace.account_tier
  account_replication_type     = var.workspace.account_replication_type
  min_tls_version              = "TLS1_2"
  public_network_access_enabled = true

  network_rules {
    default_action             = "Deny"
    bypass                     = ["AzureServices"]
    ip_rules                   = []
    virtual_network_subnet_ids = []
  }

  tags = var.default_tags
}

##########################################
# LAW Log Container
##########################################
resource "azurerm_storage_container" "law_logs" {
  name                  = "law-logs"
  storage_account_id    = azurerm_storage_account.primestorage.id
  container_access_type = "private"
}

##########################################
# Immutability Policy
##########################################
resource "azurerm_storage_container_immutability_policy" "log_lock" {
  storage_container_resource_manager_id = azurerm_storage_container.law_logs.resource_manager_id
  immutability_period_in_days           = var.log_retention_days
  protected_append_writes_enabled       = true
}


##########################################
# Automation Account
##########################################
resource "azurerm_automation_account" "automation" {
  name                = var.workspace.automation_account_name
  location            = azurerm_resource_group.lawsrg.location
  resource_group_name = azurerm_resource_group.lawsrg.name
  sku_name            = "Basic"
  tags                = var.default_tags
}

resource "azurerm_log_analytics_linked_service" "linked_automation" {
  workspace_id        = azurerm_log_analytics_workspace.lawspace.id
  resource_group_name = azurerm_resource_group.lawsrg.name
  read_access_id      = azurerm_automation_account.automation.id
}

##########################################
# LAW Linked Storage Accounts
##########################################
resource "azurerm_log_analytics_linked_storage_account" "linked_custom" {
  data_source_type      = "CustomLogs"
  workspace_resource_id = azurerm_log_analytics_workspace.lawspace.id
  resource_group_name   = azurerm_resource_group.lawsrg.name
  storage_account_ids   = [azurerm_storage_account.primestorage.id]
}

resource "azurerm_log_analytics_linked_storage_account" "linked_alerts" {
  data_source_type      = "Alerts"
  workspace_resource_id = azurerm_log_analytics_workspace.lawspace.id
  resource_group_name   = azurerm_resource_group.lawsrg.name
  storage_account_ids   = [azurerm_storage_account.primestorage.id]
}

resource "azurerm_log_analytics_linked_storage_account" "linked_queries" {
  data_source_type      = "Query"
  workspace_resource_id = azurerm_log_analytics_workspace.lawspace.id
  resource_group_name   = azurerm_resource_group.lawsrg.name
  storage_account_ids   = [azurerm_storage_account.primestorage.id]
}

##########################################
# Diagnostic Settings on LAW
##########################################
resource "azurerm_monitor_diagnostic_setting" "workspace_diagnostic" {
  name               = "${var.workspace.location}-workspace-diagnostics"
  target_resource_id = azurerm_log_analytics_workspace.lawspace.id
  storage_account_id = azurerm_storage_account.primestorage.id

  enabled_log {
    category = "Audit"
  }

  enabled_metric {
    category = "AllMetrics"
  }
}


##########################################
# Storage Lifecycle Policy
##########################################
resource "azurerm_storage_management_policy" "archive_policy" {
  storage_account_id = azurerm_storage_account.primestorage.id

  rule {
    name    = "hipaa-archive-policy"
    enabled = true

    filters {
      prefix_match = []
      blob_types   = ["blockBlob"]
    }

    actions {
      base_blob {
        tier_to_cool_after_days_since_modification_greater_than    = var.workspace.move_cool_tier
        tier_to_archive_after_days_since_modification_greater_than = var.workspace.move_archive_tier
        delete_after_days_since_modification_greater_than          = var.workspace.delete_after_modification
      }

      snapshot {
        delete_after_days_since_creation_greater_than = var.workspace.delete_snapshot
      }
    }
  }
}

##########################################
# Microsoft Solutions (If Enabled)
##########################################
resource "azurerm_log_analytics_solution" "solutions" {
  for_each = var.enable_solutions ? local.log_analytics_solution_assignments : {}

  solution_name         = each.value.solution_name
  location              = each.value.location
  resource_group_name   = each.value.resource_group_name
  workspace_resource_id = each.value.workspace_resource_id
  workspace_name        = each.value.workspace_name

  plan {
    publisher = "Microsoft"
    product   = each.value.product
  }
}

##########################################
# Export Data from LAW to Storage (If Enabled)
##########################################
resource "azurerm_log_analytics_data_export_rule" "data_export" {
  count = var.enable_data_export ? 1 : 0

  name                    = "${var.workspace.location}-data-export"
  resource_group_name     = azurerm_resource_group.lawsrg.name
  workspace_resource_id   = azurerm_log_analytics_workspace.lawspace.id
  destination_resource_id = azurerm_storage_account.primestorage.id
  table_names             = var.export_tables
  enabled                 = true
}
