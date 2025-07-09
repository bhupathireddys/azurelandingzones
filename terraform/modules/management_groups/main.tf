resource "azurerm_management_group" "root" {
  name         = var.root_management_group_name  
  display_name = var.root_management_group_name
  lifecycle {
    prevent_destroy = true
  }
}
resource "azurerm_management_group" "layer1" {
  for_each                   = { for key, value in var.layer1_management_group_names : key => value }
  display_name               = each.key
  parent_management_group_id = azurerm_management_group.root.id
  subscription_ids           = each.value.subscription_ids
}

resource "azurerm_management_group" "layer2" {
  for_each                   = { for key, value in var.layer2_management_group_names : key => value }
  display_name               = each.key
  parent_management_group_id = azurerm_management_group.layer1[each.value.parent_management_group].id
  subscription_ids           = each.value.subscription_ids
}

resource "azurerm_management_group" "layer3" {
  for_each                   = { for key, value in var.layer3_management_group_names : key => value }
  display_name               = each.key
  parent_management_group_id = azurerm_management_group.layer2[each.value.parent_management_group].id
  subscription_ids           = each.value.subscription_ids
}