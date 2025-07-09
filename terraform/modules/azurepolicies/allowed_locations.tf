# 1. Policy Definition
resource "azurerm_policy_definition" "location_restriction" {
  name                = "allowed-locations-restrict"
  management_group_id = var.management_group_id
  display_name        = "Allowed locations (centralus/westus2 only)"
  policy_type         = "Custom"
  mode                = "All"
  description         = "Restrict resource deployments to centralus and westus2 only"

  metadata = jsonencode({
    category = "Locations"
    version  = "1.0.0"
  })

  policy_rule = jsonencode({
    "if" = {
      "allOf" = [
        {
          "field" = "location",
          "notIn" = "[parameters('allowedLocations')]"
        },
        {
          "field" = "location",
          "notEquals" = "global"
        },
        {
          "field" = "type",
          "notLike" = "Microsoft.AzureActiveDirectory/*"
        }
      ]
    },
    "then" = {
      "effect" = "deny"
    }
  })

  parameters = jsonencode({
    allowedLocations = {
      type = "Array",
      metadata = {
        description = "The list of allowed locations",
        displayName = "Allowed locations",
        strongType = "location"
      },
      defaultValue = ["centralus", "westus2"]
    }
  })
}
# 2. Policy Assignment
resource "azurerm_management_group_policy_assignment" "enforce_locations" {
  name                 = "allowed-locations"
  management_group_id  = var.management_group_id
  policy_definition_id = azurerm_policy_definition.location_restriction.id
  description          = "Enforces resource creation only in centralus and westus2"
  display_name         = "Enforce Allowed Locations"
  location             = var.policy_uami_location

  parameters = jsonencode({
    allowedLocations = {
      value = ["centralus", "westus2"]
    }
  })

  identity {
    type         = "UserAssigned"
    identity_ids = [var.policy_uami_id]
  }
}

# # 3. Exemption Example (Optional - only include if needed)
# resource "azurerm_management_group_policy_exemption" "region_exception" {
#   name                 = "dr-region-exception"
#   management_group_id  = var.management_group_id
#   policy_assignment_id = azurerm_policy_definition.enforce_locations.id
#   exemption_category   = "Waiver"
#   description          = "DR region exception for BCDR"
#   expires_on           = "2024-12-31" # Set to null for permanent exemptions

#   # Optional: Scope to specific resource types
#   metadata = jsonencode({
#     requested_by  = "DR Team"
#     approved_by   = "Cloud Governance"
#     ticket_number = "INC-12345"
#   })
# }