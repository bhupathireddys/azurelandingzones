# 📘 Log Analytics Workspace Module

## 🔍 Purpose

This module provisions a single Azure Log Analytics Workspace (LAW) per environment (`prd`, `nonprd`) and region. It includes secure storage, diagnostic settings, lifecycle policies, and optional OMS solution packs and export rules.

---

## 📦 Features

| Feature                        | Description                                                      |
|-------------------------------|------------------------------------------------------------------|
| 🧪 Env-aware Workspace         | One module call per region+env (e.g., `centralus-prd`)           |
| 🔐 Secure Storage              | GRS/LRS, TLS1.2, Immutability                                    |
| 📤 Export Support              | Optional table export to storage                                 |
| 🧠 Microsoft Solutions         | Optional enablement of `SecurityInsights`, `VMInsights`, etc.    |
| 🔁 Lifecycle Policies          | Auto-tiering and deletion rules                                  |

---

## 🧾 Input Variables

| Name                  | Type        | Description                             |
|-----------------------|-------------|-----------------------------------------|
| `workspace`           | object      | Single LAW configuration                |
| `log_retention_days`  | number      | Days for blob immutability              |
| `enable_solutions`    | bool        | Enable built-in OMS packs               |
| `enable_data_export`  | bool        | Export selected tables to storage       |
| `export_tables`       | list(string)| Tables to export                        |
| `default_tags`        | map(string) | Tags applied to all resources           |

---

## 📤 Outputs

| Name                    | Description                                |
|-------------------------|--------------------------------------------|
| `workspace_id`          | Resource ID of the Log Analytics Workspace |
| `workspace_customer_id` | Customer GUID of the LAW                   |
| `automation_account_id` | ID of the Automation Account               |
| `storage_account_id`    | ID of the archive storage account          |

---

## ✅ Example Usage (Root Module)

```hcl
module "loganalyticsworkspace" {
  for_each = merge([
    for region, envs in var.loganalytics_workspaces : {
      for env, config in envs :
      "${region}-${env}" => {
        region = region
        env    = env
        config = config
      }
    }
  ]...)

  source = "./modules/loganalyticsworkspace"
  providers = { azurerm = azurerm.mgmtprdcus }

  workspace = {
    resource_group_name         = each.value.config.resource_group_name
    location                    = each.value.config.location
    loganalytics_workspace_name = each.value.config.loganalytics_workspace_name
    automation_account_name     = each.value.config.automation_account_name
    primestorage_account        = each.value.config.primestorage_account
    sku                         = each.value.config.sku
    account_tier                = each.value.config.account_tier
    account_replication_type    = each.value.config.account_replication_type
    move_cool_tier              = each.value.config.move_cool_tier
    move_archive_tier           = each.value.config.move_archive_tier
    delete_after_modification   = each.value.config.delete_after_modification
    delete_snapshot             = each.value.config.delete_snapshot
    retention_in_days           = each.value.config.retention_in_days
  }

  log_retention_days = var.log_retention_days
  enable_solutions   = var.enable_solutions
  enable_data_export = var.enable_data_export
  export_tables      = var.export_tables
  default_tags       = var.loganalytics_tags
}
