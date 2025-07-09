variable "tag_settings" {
  type = object({
    management_group_id     = string
    policy_effect           = string
    identity_location       = string
    policy_uami_id          = string
    policy_uami_client_id   = string
    policy_uami_principal_id = string
  })
  description = "Configuration for tagging policy module"
}
