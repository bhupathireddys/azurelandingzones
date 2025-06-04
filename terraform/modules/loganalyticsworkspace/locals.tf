locals {
  log_analytics_solutions = {
    SecurityInsights   = "OMSGallery/SecurityInsights"
    VMInsights         = "OMSGallery/VMInsights"
    ContainerInsights  = "OMSGallery/ContainerInsights"
  }

  log_analytics_solution_assignments = {
    for solution in flatten([
      for region_key, workspace in var.workspaces : [
        for solution_name, product in local.log_analytics_solutions : {
          key                   = "${region_key}-${solution_name}"
          solution_name         = solution_name
          product               = product
          location              = workspace.location
          resource_group_name   = workspace.resource_group_name
          workspace_resource_id = azurerm_log_analytics_workspace.lawspace[region_key].id
          workspace_name        = workspace.loganalytics_workspace_name
        }
      ]
    ]) : solution.key => solution
  }
}
