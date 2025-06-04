variable "location" {
  description = "The location where the Recovery Services vault will be created."
  type        = string
}

variable "vault_rg_name" {
  description = "Name of the resource group for the Recovery Services vault."
  type        = string
}

variable "vault_rg_location" {
  description = "Location of the resource group for the Recovery Services vault."
  type        = string
}

variable "vault_name" {
  description = "Name of the Recovery Services vault."
  type        = string
}

variable "environment" {
  description = "Environment name (e.g., dev, qa, stg, prd)."
  type        = string
}

variable "bu" {
  description = "Business Unit."
  type        = string
}

variable "costcenter" {
  description = "Cost center."
  type        = string
}

variable "owner" {
  description = "Owner of the resource."
  type        = string
}

variable "purpose" {
  description = "Purpose of the vault."
  type        = string
}

variable "backup" {
  description = "Backup enabled (Yes/No)."
  type        = string
}

variable "disasterRecovery" {
  description = "Disaster Recovery enabled (Yes/No)."
  type        = string
}

variable "projectname" {
  description = "Project name."
  type        = string
}

variable "daily_retention" {
  description = "Number of days for daily retention."
  type        = number
}

variable "weekly_retention" {
  description = "Number of weeks for weekly retention."
  type        = number
}

variable "monthly_retention" {
  description = "Number of months for monthly retention."
  type        = number
}

variable "yearly_retention" {
  description = "Number of years for yearly retention."
  type        = number
}
