variable "identity_settings" {
  type = object({
    #subscription_id   = string
    location          = string
    resource_group    = string
    identity_name     = string
    assignment_scope  = string
  })
}
