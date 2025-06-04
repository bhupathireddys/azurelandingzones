# Data block for MG lookup (ensure it's declared once globally in your module)
data "azurerm_management_group" "root" {
  display_name = var.root_management_group_name
}
