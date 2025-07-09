variable "management_group_id" {
  description = "Management Group scope for policy assignment"
  type        = string
}

variable "policy_uami_id" {
  description = "User-assigned managed identity to deploy policies"
  type        = string
}

variable "policy_uami_location" {
  description = "Location where remediation should run"
  type        = string
}
variable "policy_uami_principal_id" {
  description = " Principal ID"
  type        = string
}

variable "workspace_ids" {
  description = "Map of region-env key to corresponding LAW ID"
  type        = map(string)
}

variable "region_env_keys" {
  description = "List of region-env keys like centralus-prd, westus2-dev"
  type        = list(string)
}

variable "enforcement_phases" {
  description = "Map of env to effect like AuditIfNotExists or DeployIfNotExists"
  type        = map(string)
}
variable "subscription_policies" {
  description = "List of all subscriptions where diagnostic policies should be assigned"
  type        = list(string)
}

variable "regions_short" {
  description = "Map of Azure regions to short codes (e.g., centralus → cus)"
  type        = map(string)
}

variable "allowed_vm_skus" {
  type        = list(string)
  description = "List of allowed VM SKUs for restriction"
}
