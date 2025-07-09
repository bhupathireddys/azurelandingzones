### Global Variables ...

variable "root_management_group_name" {
  description = "Root Management Group Name"
  type = string
  default = ""
}
variable "tenant_id" {
  description = "Tenant ID for Azure authentication"
  type        = string
}

variable "client_id" {
  description = "Client ID of the Service Principal"
  type        = string
}

variable "client_secret" {
  description = "Client Secret of the Service Principal"
  type        = string
  sensitive   = true
}

variable "subscription_id" {
  description = "Azure Subscription ID"
  type        = string
}

variable "storage_account" {
  description = "Azure Storage Account Name"
  type        = string
}

variable "container_name" {
  description = "Azure Storage Container for Terraform state"
  type        = string
}

variable "resource_group_name" {
  description = "Azure Resource Group Name"
  type        = string
}

variable "auth_subscription_id" {
  description = "Subscription ID used for authentication context"
  type        = string
}

variable "environment" {
  description = "Environment identifier (e.g., dev, qa, prd)"
  type        = string
}

variable "subscription_settings" {
  type = map(object({
    subscription_name = string
    env               = string
    workload          = string
    subscription_id   = string
    root_id           = string
    cidr              = string
    region            = string
  }))
}

#### Managementgroup Module Variables

variable "layer1_management_group_names" {
  description = "The name of the layer 1 management groups and subscription IDs. A list of subscription ID is optional (useful if you want to create the layer2 level and put subscriptions there)"
  type = map(object({
    subscription_ids = optional(list(string), null)
  }))
  default = {}
}

variable "layer2_management_group_names" {
  description = "The name of the layer 2 management groups, subscription IDs and parent management group name. A list of subscription ID is optional (useful if you want to create the management groups only)"
  type = map(object({
    subscription_ids        = optional(list(string), null)
    parent_management_group = string
  }))
  default = {}
}

variable "layer3_management_group_names" {
  description = "The name of the layer 3 management groups, subscription IDs and parent management group name. A list of subscription ID is optional (useful if you want to create the management groups only)"
  type = map(object({
    subscription_ids        = optional(list(string), null)
    parent_management_group = string
  }))
  default = {}
}

##########################################
# Variables for Identity Module ####
##########################################
variable "identity_settings" {
  type = object({
    location          = string
    resource_group    = string
    identity_name     = string
    assignment_scope  = string
  })
  description = "Configuration object for creating a user-assigned managed identity"
}


##########################################
# 📊 Log Analytics Workspace Module
##########################################
variable "loganalytics_workspaces" {
  description = "Region-wise LAW config per environment (prd, nonprd)"
  type = map(map(object({
    resource_group_name         = string
    location                    = string
    loganalytics_workspace_name = string
    automation_account_name     = string
    primestorage_account        = string
    sku                         = string
    account_tier                = string
    account_replication_type    = string
    move_cool_tier              = number
    move_archive_tier           = number
    delete_after_modification   = number
    delete_snapshot             = number
    retention_in_days           = number
  })))
}

variable "log_retention_days" {
  description = "Retention period in days for logs (used for lifecycle and immutability)"
  type        = number
  default     = 365
}

variable "enable_solutions" {
  description = "Enable Microsoft OMS solutions like SecurityInsights, VMInsights"
  type        = bool
  default     = false
}

variable "enable_data_export" {
  description = "Enable continuous export to storage for selected tables"
  type        = bool
  default     = false
}

variable "export_tables" {
  description = "Tables to export if data export is enabled"
  type        = list(string)
  default     = ["AzureActivity", "SecurityEvent", "Heartbeat"]
}

variable "loganalytics_tags" {
  type        = map(string)
  description = "Tags for Log Analytics resources"
}


# # ##########################################
# # # 🔐 Azure Policies Module
# # ##########################################


variable "enforcement_phases" {
  type = map(string)
}
variable "subscription_policies" {
  description = "List of all subscriptions where diagnostic policies should be assigned"
  type        = list(string)
}

variable "regions_short" {
  description = "Short codes for Azure regions"
  type = map(string)
  default = {
    centralus = "cus"
    westus2   = "wus2"
    # Add other regions as needed
  }
}

variable "allowed_vm_skus" {
  type        = list(string)
  description = "List of allowed VM SKUs for restriction"
}

