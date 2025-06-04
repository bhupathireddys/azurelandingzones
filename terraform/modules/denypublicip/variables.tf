variable "management_group_id" {
  type        = string
  description = "The ID of the management group to create the policy in"
}

variable "spoke_subscription_ids" {
  type        = map(string)
  description = "Map of spoke subscription keys to their IDs"
}
