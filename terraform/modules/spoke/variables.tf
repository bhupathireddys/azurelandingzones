variable "subscription_settings" {
  type = object({
    subscription_name = string
    env               = string
    workload          = string
    subscription_id   = string
    root_id           = string
    cidr              = string
    region            = string
  })
}

variable "regions_short" {
  type = map(string)
}

variable "enable_firewall" {
  type = bool
}

variable "primary_hub_fw_ip" {
  type        = string
  default     = null
}

variable "secondary_hub_fw_ip" {
  type        = string
  default     = null
}
