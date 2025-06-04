# Azure Policies Module

This Terraform module enforces Azure enterprise governance policies across your landing zones using Azure Policy, Initiative Assignments, and remediation capabilities.

It supports centralized enforcement at the **management group level**, using a **User Assigned Managed Identity** for all policy assignments and deployIfNotExists operations.

---

## 📁 Module Structure

| File / Folder | Purpose |
|---------------|---------|
| `variables.tf` | Declares input variables like `management_group_id`, `location`, `primary_law_id`, etc. |
| `providers.tf` | Configures the `azurerm` provider scoped to the management group. |
| `outputs.tf` | Outputs identity-related values for downstream use. |
| `identity.tf` | Provisions the User Assigned Managed Identity (UAMI) for policy remediation. |
| `assign_diagnostic_settings.tf` | Assigns policy to enforce diagnostic settings on critical Azure services. |
| `enable-diagnostic-settings-policy.tf` | Defines the custom policy for enforcing diagnostic settings. |
| `enable-diagnostic-settings-policy.json` | JSON logic to deploy diagnostic settings to Log Analytics. |
| `activitylogs-to-workspace.json` | Policy to send subscription activity logs to a central Log Analytics workspace. |
| `activitylogs-to-worksapce.tf` | Assigns the above policy at the management group level. |
| `assign_activitylogs_workspaces.tf` | Sets up the required assignments for activity log ingestion. |
| `audit-storage-require-private-endpoint-policy.json` | Policy to audit storage accounts missing private endpoints. |
| `audit-storage-require-private-endpoint.tf` | Assigns the audit policy to monitor storage account compliance. |
| `deny-public-storage-access-policy.json` | Policy to deny public access via Blob or Shared Keys. |
| `deny-public-storage-access.tf` | Assigns the above policy to enforce secure storage defaults. |
| `enforce-keyvault-softdelete-policy.json` | Policy to deny Key Vault creation without soft-delete and purge protection. |
| `enforce-keyvault-softdelete.tf` | Assigns the above policy. |
| `enforce-vm-encryption-at-host-policy.json` | Custom policy to deny VM creation if `encryptionAtHost` is not enabled. |
| `enforce-vm-encryption-at-host.tf` | Assigns the policy at the management group level. |
| `deny_insecure_nsg_any_any.tf` | Denies NSG rules that allow `Any → Any` inbound from 0.0.0.0/0. |
| `deny_rdp_ssh_from_internet.tf` | Denies inbound SSH (22) and RDP (3389) from public IPs. |
| `deny-nonprd-dr-tag.tf` | Denies setting `disasterrecovery = Yes` tag on non-`prd` environments. |
| `restrict_vm_sizes_def.tf` | Enforces VM SKU limitations (e.g., only approved sizes in spokes). |

---

## ✅ Policy Summary

### 🔒 Security & Network Policies
| Policy | Purpose |
|--------|---------|
| `deny_insecure_nsg_any_any.tf` | Prevents overly permissive NSG rules (0.0.0.0/0 to Any port). |
| `deny_rdp_ssh_from_internet.tf` | Blocks SSH/RDP access from public internet. |
| `enforce-vm-encryption-at-host.tf` | Ensures VMs are created with `encryptionAtHost = true`. |
| `restrict_vm_sizes_def.tf` | Restricts VM SKUs to approved list per environment. |

---

### 🗄️ Storage & Data Protection
| Policy | Purpose |
|--------|---------|
| `deny-public-storage-access.tf` | Denies storage accounts that allow public access or shared keys. |
| `audit-storage-require-private-endpoint.tf` | Flags storage accounts missing private endpoints. |
| `enforce-keyvault-softdelete.tf` | Denies Key Vaults without soft-delete and purge protection. |

---

### 📊 Monitoring & Diagnostics
| Policy | Purpose |
|--------|---------|
| `assign_diagnostic_settings.tf` + `enable-diagnostic-settings-policy.tf` | Enforces diagnostics for VMs, SQL, Key Vault, WebApps, NSGs, etc. |
| `activitylogs-to-worksapce.tf` + `assign_activitylogs_workspaces.tf` | Ensures activity logs are forwarded to Log Analytics workspace. |

---

### 🏷️ Tag Governance & Compliance
| Policy | Purpose |
|--------|---------|
| `deny-nonprd-dr-tag.tf` | Prevents applying `disasterrecovery = Yes` to `dev/qa/stg` workloads. |

---

## ⚙️ Inputs

| Variable | Description |
|----------|-------------|
| `management_group_id` | Scope for all policy assignments (usually the root MG). |
| `location` | Azure region for assignment metadata (e.g., `centralus`). |
| `primary_law_id` | Log Analytics Workspace ID used for diagnostic settings. |
| `policy_uami_id` | UAMI used for remediation deployments. |
| `log_retention_in_days` | Retention period for diagnostic logs and metrics. |

---

## 📤 Outputs

| Output | Description |
|--------|-------------|
| `policy_uami_id` | Identity ID of the policy enforcement UAMI |
| `policy_uami_client_id` | Client ID of the UAMI |
| `policy_uami_principal_id` | Object ID for role assignments |

---

## 📌 Notes

- Ensure `azurerm_user_assigned_identity.policy_uami` has **Resource Policy Contributor** role on the management group.
- Policies using `deployIfNotExists` require elevated permissions during assignment.
- Diagnostic and tagging policies can be extended using the same module pattern.
- Avoid `metadata` inside `.json` files — define it in `.tf` using `metadata = jsonencode(...)`.

---

## 🧪 Validation

To validate before applying:

```bash
terraform validate
terraform plan -var-file="env.tfvars"
terraform apply -var-file="env.tfvars"
