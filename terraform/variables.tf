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

variable "environment" {
  description = "Deployment environment (stg/prod)"
  type        = string
}

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