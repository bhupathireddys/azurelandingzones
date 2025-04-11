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

variable "regions_short" {
  type = map(string)
}

variable "enable_firewall" {
  type = bool
}

variable "firewall_sku" {
  type    = string
  default = "Basic"
}
