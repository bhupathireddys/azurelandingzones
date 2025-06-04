variable "asr_vault_name" {
  description = "Name of the Recovery Services Vault for ASR"
  type        = string
}

variable "dr_rg_name" {
  description = "Name of the Resource Group for ASR vault"
  type        = string
}

variable "dr_rg_location" {
  description = "Region where the ASR Resource Group is created"
  type        = string
}

variable "dr_target_location" {
  description = "Region to failover during DR (target region)"
  type        = string
}

variable "target_resource_group_id" {
  description = "Resource Group ID where VMs will be failed over"
  type        = string
}

variable "environment" {
  description = "Environment (e.g., dev, qa, stg, prd)"
  type        = string
}

variable "bu" {
  description = "Business unit name"
  type        = string
}

variable "costcenter" {
  description = "Cost center code"
  type        = string
}

variable "owner" {
  description = "Owner of the resources"
  type        = string
}

variable "purpose" {
  description = "Purpose of the vault (e.g., disaster-recovery)"
  type        = string
}

variable "backup" {
  description = "Indicates if backup is enabled (Yes/No)"
  type        = string
}

variable "disasterRecovery" {
  description = "Indicates if DR is enabled (Yes/No)"
  type        = string
}

variable "projectname" {
  description = "Associated project name"
  type        = string
}
