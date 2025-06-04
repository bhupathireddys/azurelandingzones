 Azure Backup Vaults & Auto-Backup Policy Deployment
This solution provisions Recovery Services Vaults for multiple environments (Dev, QA, Stg, Prd) and auto-enables backup for newly created Azure VMs based on resource tags using Azure Policy.

📁 Module Structure
bash
Copy
Edit
modules/
├── backupvaults/
│   ├── main.tf             # Creates Recovery Services Vaults with backup policies
│   ├── variables.tf        # Vault input variables
│   ├── outputs.tf          # Vault outputs
│   ├── providers.tf        # Provider setup
│   └── policy/
│       ├── auto_enable_backup.tf   # Policy Definition
│       ├── assign_backup.tf        # Policy Assignment
│       ├── outputs.tf              # Policy Outputs
│       ├── variables.tf            # Policy variables
🏗️ Features
✅ Create Backup Vaults per environment (dev, qa, stg, prd)

✅ Configure Retention Policies (daily, weekly, monthly, yearly)

✅ Enable backup automatically for VMs with:

backup = Yes

env = dev/qa/stg/prd

✅ Auto-associate VM to respective vault based on environment

✅ Management Group level policy assignment

🛠️ Input Variables
For modules/backupvaults

Name	Description	Type	Required
environments	Map of environment-specific vault details and retention settings	map(object)	✅
For modules/backupvaults/policy

Name	Description	Type	Required
management_group_id	Management Group ID where policies are assigned	string	✅
backup_mapping	Mapping of environment ➔ vault name + backup policy ID	map(object)	✅
📋 Example Usage (Root Module)
hcl
Copy
Edit
module "backupvaults" {
  for_each = var.environments

  source            = "./modules/backupvaults"
  providers         = { azurerm = azurerm.mgmtprdcus }
  location          = each.value.location
  vault_rg_name     = each.value.vault_rg_name
  vault_rg_location = each.value.vault_rg_location
  vault_name        = each.value.vault_name
  environment       = each.value.environment
  bu                = each.value.bu
  costcenter        = each.value.costcenter
  owner             = each.value.owner
  purpose           = each.value.purpose
  backup            = each.value.backup
  disasterRecovery  = each.value.disasterRecovery
  projectname       = each.value.projectname
  daily_retention   = each.value.daily_retention
  weekly_retention  = each.value.weekly_retention
  monthly_retention = each.value.monthly_retention
  yearly_retention  = each.value.yearly_retention
}

module "backupvaults_policy" {
  source              = "./modules/backupvaults/policy"
  management_group_id = var.management_group_id
  backup_mapping      = var.backup_mapping
}
📑 Sample infrarnd.tfvars
hcl
Copy
Edit
# Backup Vaults
environments = {
  dev = {
    location          = "Central US"
    vault_rg_name     = "backup-dev-rg"
    vault_rg_location = "Central US"
    vault_name        = "rsv-dev"
    ...
  }
  ...
}

# Policy Mapping
backup_mapping = {
  dev = {
    vault_name       = "rsv-dev"
    backup_policy_id = "/subscriptions/xxxx/resourceGroups/backup-dev-rg/providers/Microsoft.RecoveryServices/vaults/rsv-dev/backupPolicies/defaultPolicy"
  }
  ...
}

# Management Group ID
management_group_id = "/providers/Microsoft.Management/managementGroups/<mgmt-group-id>"
