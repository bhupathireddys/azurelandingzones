variable "management_group_id" {
  description = "The management group ID to assign the policy to"
  type        = string
}

variable "policy_uami_id" {
  description = "ID of the user-assigned managed identity"
  type        = string
}

variable "policy_uami_principal_id" {
  description = "Principal ID of the user-assigned managed identity"
  type        = string
}

variable "policy_uami_client_id" {
  description = "Client ID of the user-assigned managed identity"
  type        = string
}

variable "backup_mapping" {
  description = "Mapping of environments to their backup vault details"
  type = map(object({
    vault_name       = string
    backup_policy_id = string
  }))
}

variable "location" {
  description = "location of vaults"
  type        = string
}