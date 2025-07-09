locals {
  log_analytics_solutions = {
    SecurityInsights   = "OMSGallery/SecurityInsights"
    VMInsights         = "OMSGallery/VMInsights"
    ContainerInsights  = "OMSGallery/ContainerInsights"
  }

  log_analytics_solution_assignments = {
    for solution_name, product in local.log_analytics_solutions : 
    solution_name => {
      solution_name         = solution_name
      product               = product
      location              = var.workspace.location
      resource_group_name   = var.workspace.resource_group_name
      workspace_resource_id = azurerm_log_analytics_workspace.lawspace.id
      workspace_name        = var.workspace.loganalytics_workspace_name
    }
  }
}
