resource "azurerm_policy_definition" "restrict_vm_sizes" {
  name                 = "restrict-vm-sizes"
  policy_type          = "Custom"
  mode                 = "All"
  management_group_id  = var.management_group_id
  display_name         = "Restrict VM Size Types "
  description          = "Restrict VM SKU sizes across Azure"

  parameters = jsonencode({
    allowed_vm_skus = {
      type = "Array"
      metadata = {
        displayName = "Allowed VM SKUs"
        description = "List of allowed VM SKU sizes."
      }
    }
  })

  policy_rule = jsonencode({
    "if": {
      "allOf": [
        {
          "field": "type",
          "equals": "Microsoft.Compute/virtualMachines"
        },
        {
          "not": {
            "field": "Microsoft.Compute/virtualMachines/sku.name",
            "in": "[parameters('allowed_vm_skus')]"
          }
        }
      ]
    },
    "then": {
      "effect": "Deny"
    }
  })
}

resource "azurerm_management_group_policy_assignment" "restrict_vm_sizes" {
  name                 = "restrict-vm-sizes"
  display_name         = "Restrict VM Size Types"
  policy_definition_id = azurerm_policy_definition.restrict_vm_sizes.id
  management_group_id  = var.management_group_id
  location             = var.policy_uami_location
  enforce              = true

  identity {
    type         = "UserAssigned"
    identity_ids = [var.policy_uami_id]
  }

  parameters = jsonencode({
    allowed_vm_skus = {
      value = var.allowed_vm_skus
    }
  })

  non_compliance_message {
    content = "Only allowed VM SKUs supporting 'encryption at host' are permitted."
  }

  depends_on = [
    azurerm_policy_definition.restrict_vm_sizes
  ]
}
