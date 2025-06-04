locals {
  workspace_solution_map = {
    "centralus" = [
      "AgentHealthAssessment", "Security", "SQLAssessment",
      "VMInsights", "Updates", "ChangeTracking"
    ]
    "westus2" = [
      "AgentHealthAssessment", "Security", "SQLAssessment",
      "VMInsights", "Updates", "ChangeTracking"
    ]
  }
}

# Resource Group
resource "azurerm_resource_group" "lawsrg" {
  for_each = var.workspaces
  name     = each.value.resource_group_name
  location = each.value.location
}

# Log Analytics Workspace
resource "azurerm_log_analytics_workspace" "lawspace" {
  for_each            = var.workspaces
  name                = each.value.loganalytics_workspace_name
  location            = azurerm_resource_group.lawsrg[each.key].location
  resource_group_name = azurerm_resource_group.lawsrg[each.key].name
  sku                 = each.value.sku
  retention_in_days   = each.value.retention_in_days

  # 🔐 Network isolation
 # public_network_access_for_ingestion_enabled = false
  #public_network_access_for_query_enabled     = false
  internet_ingestion_enabled                  = true   # Allow from Azure services
  internet_query_enabled                      = true   # Allow from Azure services

  tags = {
    HIPAA_Compliant = "true"
  }
}

# Secure Storage Account per region
resource "azurerm_storage_account" "primestorage" {
  for_each                         = var.workspaces
  name                             = each.value.primestorage_account
  resource_group_name              = azurerm_resource_group.lawsrg[each.key].name
  location                         = azurerm_resource_group.lawsrg[each.key].location
  account_tier                     = each.value.account_tier
  account_replication_type         = each.value.account_replication_type
  min_tls_version                  = "TLS1_2"
  public_network_access_enabled   = true


  network_rules {
    default_action             = "Deny"
    bypass                     = ["AzureServices"]
    ip_rules                   = []
    virtual_network_subnet_ids = []
  }

  tags = {
    HIPAA_Compliant = "true"
  }
}

# Create container to hold LAW logs
resource "azurerm_storage_container" "law_logs" {
  for_each              = var.workspaces
  name                  = "law-logs"
  storage_account_id = azurerm_storage_account.primestorage[each.key].id
  container_access_type = "private"
}

resource "azurerm_storage_container_immutability_policy" "log_lock" {
  for_each = var.workspaces

  storage_container_resource_manager_id = azurerm_storage_container.law_logs[each.key].resource_manager_id
  immutability_period_in_days           = var.log_retention_days

  protected_append_writes_enabled       = true
  protected_append_writes_all_enabled   = false
}

# Automation Account per region
resource "azurerm_automation_account" "automation" {
  for_each            = var.workspaces
  name                = each.value.automation_account_name
  location            = azurerm_resource_group.lawsrg[each.key].location
  resource_group_name = azurerm_resource_group.lawsrg[each.key].name
  sku_name            = "Basic"
}

# Link Automation Account to LAW
resource "azurerm_log_analytics_linked_service" "linked_automation" {
  for_each            = var.workspaces
  workspace_id        = azurerm_log_analytics_workspace.lawspace[each.key].id
  resource_group_name = azurerm_resource_group.lawsrg[each.key].name
  read_access_id      = azurerm_automation_account.automation[each.key].id
}

# Linked Storage Accounts
resource "azurerm_log_analytics_linked_storage_account" "linked_custom" {
  for_each              = var.workspaces
  data_source_type      = "CustomLogs"
  workspace_resource_id = azurerm_log_analytics_workspace.lawspace[each.key].id
  resource_group_name   = azurerm_resource_group.lawsrg[each.key].name
  storage_account_ids   = [azurerm_storage_account.primestorage[each.key].id]
}

resource "azurerm_log_analytics_linked_storage_account" "linked_alerts" {
  for_each              = var.workspaces
  data_source_type      = "Alerts"
  workspace_resource_id = azurerm_log_analytics_workspace.lawspace[each.key].id
  resource_group_name   = azurerm_resource_group.lawsrg[each.key].name
  storage_account_ids   = [azurerm_storage_account.primestorage[each.key].id]
}

resource "azurerm_log_analytics_linked_storage_account" "linked_queries" {
  for_each              = var.workspaces
  data_source_type      = "Query"
  workspace_resource_id = azurerm_log_analytics_workspace.lawspace[each.key].id
  resource_group_name   = azurerm_resource_group.lawsrg[each.key].name
  storage_account_ids   = [azurerm_storage_account.primestorage[each.key].id]
}

# LAW Diagnostic Settings
resource "azurerm_monitor_diagnostic_setting" "workspace_diagnostic" {
  for_each           = var.workspaces
  name               = "${each.key}-workspace-diagnostics"
  target_resource_id = azurerm_log_analytics_workspace.lawspace[each.key].id
  storage_account_id = azurerm_storage_account.primestorage[each.key].id

  enabled_log {
    category = "Audit"
  }

  metric {
    category = "AllMetrics"
    enabled  = true
  }
}

# Storage Lifecycle Policy (HIPAA compliant)
resource "azurerm_storage_management_policy" "archive_policy" {
  for_each           = var.workspaces
  storage_account_id = azurerm_storage_account.primestorage[each.key].id

  rule {
    name    = "hipaa-archive-policy"
    enabled = true
    filters {
      prefix_match = []
      blob_types   = ["blockBlob"]
    }

    actions {
      base_blob {
        tier_to_cool_after_days_since_modification_greater_than    = 30
        tier_to_archive_after_days_since_modification_greater_than = 90
        delete_after_days_since_modification_greater_than          = var.log_retention_days
      }

      snapshot {
        delete_after_days_since_creation_greater_than = var.log_retention_days
      }
    }
  }
}

# Insights Solution Map
resource "azurerm_log_analytics_solution" "solutions" {
  for_each = local.log_analytics_solution_assignments

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

# Continuous Export to Storage
resource "azurerm_log_analytics_data_export_rule" "data_export" {
  for_each = var.enable_data_export ? var.workspaces : {}

  name                    = "${each.key}-data-export"
  resource_group_name     = each.value.resource_group_name
  workspace_resource_id   = azurerm_log_analytics_workspace.lawspace[each.key].id
  destination_resource_id = azurerm_storage_account.primestorage[each.key].id
  table_names             = var.export_tables
  enabled                 = true
}

