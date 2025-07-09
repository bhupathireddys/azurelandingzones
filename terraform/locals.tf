
# Assuming this comes from loganalyticsworkspace module
locals {
  region_env_keys = keys(module.loganalyticsworkspace)

  workspace_ids = {
    for key, mod in module.loganalyticsworkspace :
    key => mod.workspace_id
  }

}
