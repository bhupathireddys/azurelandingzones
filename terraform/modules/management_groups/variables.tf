
############## Modules Variables ################

variable "root_management_group_name" {
  description = "The name of the root management group."
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