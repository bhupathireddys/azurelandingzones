# 📘 Azure Log Analytics Workspace Module

## 🔍 Purpose

This Terraform module provisions **centralized Log Analytics Workspaces (LAW)** per region, optimized for:

- ✅ **Enterprise-wide diagnostic data collection**
- ✅ **HIPAA and healthcare security compliance**
- ✅ **Cost-effective long-term log retention**
- ✅ **Integration with Azure Policy, Automation, and Monitoring**

---

## 📦 Features

| Feature                          | Description                                                                 |
|----------------------------------|-----------------------------------------------------------------------------|
| 🔄 Regional Workspaces           | LAW is created per region (e.g., `centralus`, `westus2`)                   |
| 🔒 GRS-Enabled Storage           | Storage accounts with **immutability** and **lifecycle rules**             |
| 🛠 Automation Accounts           | For workbook & scheduled task integration                                  |
| 🧠 Solution Packs                | Pre-configured `SecurityInsights`, `VMInsights`, `ContainerInsights`       |
| 🔗 Outputs                       | Used in other modules (`azurepolicies`) to enforce diagnostic settings     |

---

## 🧩 Inter-Module Dependencies

| Consumed By Module | Output Used                         | Purpose                                       |
|--------------------|-------------------------------------|-----------------------------------------------|
| `azurepolicies`    | `workspace_ids["centralus"]`        | Diagnostic/Activity log policy enforcement    |
| `drautomation`     | No dependency                        | -                                             |
| `asr` / `backupvaults` | No dependency                    | -                                             |

---

## 📁 Files

- `main.tf` – Creates Log Analytics Workspaces, automation accounts, and storage
- `locals.tf` – Regional mappings and solution configurations
- `outputs.tf` – Workspace and storage IDs used by other modules
- `variables.tf` – Configurable regions and retention policies

---

## 📤 Outputs

| Output Name             | Description                                        |
|-------------------------|----------------------------------------------------|
| `workspace_ids`         | Log Analytics Workspace resource IDs (per region) |
| `workspace_customer_ids`| Workspace GUIDs for data connector integration     |
| `automation_account_ids`| IDs of automation accounts created per region     |
| `storage_account_ids`   | Immutable GRS storage accounts for log export     |

---

## ✅ Best Practices Included

- ✅ GRS Storage for **immutable retention**
- ✅ Lifecycle rules for **tiering and deletion**
- ✅ Parameterized **retention duration**
- ✅ Secure, compliant solution packs for monitoring
- ✅ Optimized to avoid over-ingestion and cost spikes

---

## 🚫 What This Module Avoids

| Not Included                   | Reason                                      |
|--------------------------------|---------------------------------------------|
| NSG flow logs                  | Not included by default, can be added if needed |
| Overlapping metrics ingestion | Cost optimization best practice            |
| Full all-logs ingestion        | Uses filtered categories via policy        |

---

## 📘 Example Usage (Root Module)

```hcl
module "loganalyticsworkspace" {
  source = "./modules/loganalyticsworkspace"

  location = "centralus"
  environment = "prod"
  log_retention_days = 365

  regions = {
    centralus = {
      log_analytics_workspace_name = "law-centralus"
      storage_account_name         = "lawarchivestgcentral"
      automation_account_name      = "lawauto-centralus"
    }
    westus2 = {
      log_analytics_workspace_name = "law-westus2"
      storage_account_name         = "lawarchivestgwest"
      automation_account_name      = "lawauto-westus2"
    }
  }
}
