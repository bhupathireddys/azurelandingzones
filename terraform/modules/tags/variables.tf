# modules/tags/variables.tf

variable "management_group_id" {
  description = "Management group ID where the tag policies will be assigned."
  type        = string
}

variable "policy_effect" {
  description = "The effect for the tag policies (e.g., AuditIfNotExists or Deny)."
  type        = string
  default     = "AuditIfNotExists"
}
variable "identity_location" {
  description = "Azure region for user-assigned managed identity"
  type        = string
}
variable "policy_uami_id" {
  description = "User-assigned managed identity ID for tagging policy assignment"
  type        = string
}

variable "policy_uami_client_id" {
  description = "User-assigned managed identity Client ID for tagging policy assignment"
  type        = string
}

variable "policy_uami_principal_id" {
  description = "User-assigned managed identity Principal ID for tagging policy assignment"
  type        = string
}
