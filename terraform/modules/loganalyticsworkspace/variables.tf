
variable "workspaces" {
  description = "Map of region-wise workspace and storage configurations"
  type = map(object({
    resource_group_name         = string
    location                    = string
    loganalytics_workspace_name = string
    sku                         = string
    retention_in_days           = number
    primestorage_account        = string
    account_tier                = string
    account_replication_type    = string
    automation_account_name     = string
    move_cool_tier              = number
    move_archive_tier           = number
    delete_after_modification   = number
    delete_snapshot             = number
  }))
}


variable "log_retention_days" {
  description = "Retention period in days for log data"
  type        = number
  default     = 365
}
variable "enable_solutions" {
  description = "Enable built-in Microsoft solutions (e.g., SecurityInsights)"
  type        = bool
  default     = false
}

variable "enable_data_export" {
  description = "Enable data export rule to storage (only after tables exist)"
  type        = bool
  default     = false
}

variable "export_tables" {
  description = "List of tables to export from Log Analytics"
  type        = list(string)
  default     = ["AzureActivity", "SecurityEvent", "Heartbeat"]
}
