output "tagging_policy_assignment_id" {
  description = "The ID of the tagging policy assignment"
  value       = azurerm_management_group_policy_assignment.assign_tagging_initiative.id
}
