resource "azurerm_policy_definition" "restrict_vm_sizes" {
  name                 = "restrict-vm-sizes"
  policy_type          = "Custom"
  mode                 = "All"
  management_group_id  = var.management_group_id
  display_name         = "Restrict VM Size Types in Spokes"
  description          = "Restrict VM SKU sizes in Spoke subscriptions."

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
  display_name         = "Restrict VM Size Types in Spokes"
  policy_definition_id = azurerm_policy_definition.restrict_vm_sizes.id
  management_group_id  = var.management_group_id
  enforce              = true

  parameters = jsonencode({
    allowed_vm_skus = {
      value = var.allowed_vm_skus
    }
  })
}

