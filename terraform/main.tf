############ Module for managementgroups ###############

module "management_groups" {
  source = "./modules/management_groups"
  root_management_group_name    = var.root_management_group_name
  layer1_management_group_names = var.layer1_management_group_names
  layer2_management_group_names = var.layer2_management_group_names
  layer3_management_group_names = var.layer3_management_group_names
}
