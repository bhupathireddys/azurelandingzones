
############## Module Outputs ################
output "root_management_group_id" {
  description = "Root Management Group ID"
  value       = { (azurerm_management_group.root.display_name) = azurerm_management_group.root.id }
}

output "layer1_management_group_ids" {
  description = "Layer 1 Management Group IDs"
  value       = {
    for key, group in azurerm_management_group.layer1 : key => group.id
  }
}

output "layer2_management_group_ids" {
  description = "Layer 2 Management Group IDs"
  value       = {
    for key, group in azurerm_management_group.layer2 : key => group.id
  }
}

output "layer3_management_group_ids" {
  description = "Layer 3 Management Group IDs"
  value       = {
    for key, group in azurerm_management_group.layer3 : key => group.id
  }
}
