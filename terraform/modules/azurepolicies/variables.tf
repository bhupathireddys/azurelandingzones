variable "assignment_scope" {
  description = "Management group scope for policy assignment"
  type        = string
}

variable "allowed_vm_skus" {
  type = list(string)
  description = "List of allowed VM SKUs"
}
variable "management_group_id" {
  description = "ID of the management group"
  type        = string
}

variable "root_management_group_name" {
  description = "Root management group name for policy assignment and audit"
  type        = string
}

variable "identity_resource_group" {
  description = "Resource group for user-assigned managed identity"
  type        = string
}

variable "identity_location" {
  description = "Azure region for user-assigned managed identity"
  type        = string
}

variable "policy_effect" {
  description = "Effect of policy definitions (AuditIfNotExists or Deny)"
  type        = string
  default     = "AuditIfNotExists"
}
variable "location" {
  description = "Default region for identity and policy assignments"
  type        = string
}

variable "primary_law_id" {
  description = "Resource ID of the central Log Analytics Workspace"
  type        = string
}

variable "log_retention_in_days" {
  description = "Number of days to retain diagnostic logs and metrics"
  type        = number
}
##################################
# Common Policy Variables
##################################

# variable "management_group_id" {
#   description = "The Management Group ID where the policies are assigned."
#   type        = string
# }

# variable "assignment_scope" {
#   description = "Scope for policy assignment."
#   type        = string
# }

# variable "location" {
#   description = "Azure region for policies assignment (e.g., centralus)."
#   type        = string
# }

# variable "policy_effect" {
#   description = "Effect to apply (AuditIfNotExists, Deny, etc.)."
#   type        = string
#   default     = "Deny"
# }

##################################
# Diagnostic & Tagging Policies
##################################

# variable "allowed_vm_skus" {
#   description = "List of allowed VM SKUs for restriction policy."
#   type        = list(string)
# }

# variable "identity_resource_group" {
#   description = "Resource group where the managed identity (UAMI) exists."
#   type        = string
# }

# variable "identity_location" {
#   description = "Location of the managed identity."
#   type        = string
# }

# variable "log_retention_in_days" {
#   description = "Log retention period in Log Analytics (days)."
#   type        = number
#   default     = 30
# }

# variable "primary_law_id" {
#   description = "Resource ID of the primary Log Analytics Workspace."
#   type        = string
# }

# variable "spoke_subscription_ids" {
#   description = "Map of spoke subscription IDs (keyed by workload/project name)."
#   type        = map(string)
# }

variable "policy_uami_principal_id" {
  description = "User-assigned managed identity Principal ID for tagging policy assignment"
  type        = string
}




