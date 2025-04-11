variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "firewall_subnet_id" {
  type = string
}

variable "management_subnet_id" {
  type = string
}

variable "sku_tier" {
  type    = string
  default = "Standard"
}

variable "root_id" {
  type = string
}

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
