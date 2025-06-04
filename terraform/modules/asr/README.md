# Azure Site Recovery Vault Module

## 📖 Overview
This module deploys an Azure Recovery Services Vault (ASR Vault) for enabling disaster recovery (DR) scenarios. 
Each environment (dev, qa, stg, prd) can have its own vault with tagging and cross-region failover settings.

---

## 🚀 Features
- Creates ASR Vault with soft delete and cross-region restore enabled
- Applies organization-level tags (env, bu, costcenter, project, backup, DR, purpose)
- Outputs vault ID, name, and region
- Prepares for future Site Recovery protection setup (outside this module)

---

## 🔧 Inputs
| Name | Description | Type |
|:---|:---|:---|
| asr_vault_name | Name of ASR Vault | string |
| dr_rg_name | Resource Group name | string |
| dr_rg_location | Resource Group location | string |
| dr_target_location | DR Failover target location | string |
| target_resource_group_id | Resource Group ID for failover | string |
| environment | Environment type | string |
| bu | Business unit | string |
| costcenter | Cost center | string |
| owner | Owner name/email | string |
| purpose | Purpose of vault | string |
| backup | Backup enabled flag | string |
| disasterRecovery | Disaster Recovery enabled flag | string |
| projectname | Project name | string |

---

## 📤 Outputs
| Name | Description |
|:---|:---|
| asr_vault_id | ASR Vault Resource ID |
| asr_vault_name | ASR Vault Name |
| asr_vault_rg | Resource Group Name |
| asr_vault_location | Region of Vault |

---

## 🗺️ Architecture Diagram

(📌 *Diagram will be attached in final doc!*)

---

## 📜 Notes
- **Auto-Protection of VMs is not handled here.** 
- Manual or separate automation is needed for enabling replication.
