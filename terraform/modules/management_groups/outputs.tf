
############## Module Outputs ################
output "root_management_group_id" {
  description = "Root Management group ID"
  value       = { (azurerm_management_group.root.display_name) = azurerm_management_group.root.id }
}
output "layer1_management_group_ids" {
  description = "Tier1 Management groups IDs"
  value       = { for key, value in azurerm_management_group.layer1 : key => value.id }
}

output "layer2_management_group_ids" {
  description = "Tier2 Management groups IDs"
  value       = { for key, value in azurerm_management_group.layer2 : key => value.id }
}

output "layer3_management_group_ids" {
  description = "Layer 3 Management groups IDs"
  value       = { for key, value in azurerm_management_group.layer3 : key => value.id }
}