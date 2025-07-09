resource "azurerm_subscription_policy_assignment" "diagnostics_assignments" {
  for_each = {
    for rt in keys(local.resource_diagnostics) : rt => rt
  }

  name                 = "diag-${replace(each.value, "/[^a-zA-Z0-9]/", "")}"
  display_name         = "Diagnostics for ${each.value}"
  description          = "Enables diagnostics for ${each.value}"
  policy_definition_id = azurerm_policy_definition.central_diagnostics.id
  subscription_id      = "/subscriptions/${var.subscription_policies[0]}" # Adjust as needed
  enforce             = true
  location            = var.policy_uami_location

  identity {
    type         = "UserAssigned"
    identity_ids = [var.policy_uami_id]
  }

  parameters = jsonencode({
    workspaceId = {
      value = var.workspace_ids[local.split_region_env["${var.subscription_policies[0]}-${var.region_env_keys[0]}"].law_key]
    },
    effect = {
      value = var.enforcement_phases[local.split_region_env["${var.subscription_policies[0]}-${var.region_env_keys[0]}"].env]
    },
    resourceType = {
      value = each.value
    }
  })

  metadata = jsonencode({
    resource_discovery_mode = "ReEvaluateCompliance"
    assigned_by            = "Terraform"
  })
}