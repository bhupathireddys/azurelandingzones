📖 README - modules/backupvaults/policy
📋 Purpose
This module auto-enables backup for Azure Virtual Machines (VMs) based on their environment tags (dev, qa, stg, prd).

✅ Dynamically selects the correct Recovery Services Vault
✅ Attaches the VM to the correct Backup Policy
✅ No manual backup configuration needed for new VMs
✅ Fully reusable for any organization without hardcoded values

🛠️ How It Works
Policy Definitions:
Separate policy definition files for each environment:

auto_enable_backup_dev.tf

auto_enable_backup_qa.tf

auto_enable_backup_stg.tf

auto_enable_backup_prd.tf

Policy Assignment:
Assigns policies at the Management Group level to ensure new VMs with tags:

backup = Yes

env = dev | qa | stg | prd

...are automatically protected via backup!

Mapping:
Backup Vault and Backup Policy IDs are mapped dynamically using backup_mapping.

🧩 Inputs

Variable	Description
management_group_id	Management Group where the policies will be assigned
backup_mapping	Map of environment → vault name and backup policy ID
Example:

hcl
Copy
Edit
backup_mapping = {
  dev = {
    vault_name       = "rsv-dev"
    backup_policy_id = "/subscriptions/xxx/resourceGroups/backup-dev-rg/providers/Microsoft.RecoveryServices/vaults/rsv-dev/backupPolicies/defaultPolicy"
  }
  ...
}
📤 Outputs

Output	Description
auto_enable_backup_dev_policy_definition_id	Policy ID for dev
auto_enable_backup_qa_policy_definition_id	Policy ID for qa
auto_enable_backup_stg_policy_definition_id	Policy ID for stg
auto_enable_backup_prd_policy_definition_id	Policy ID for prd
🚀 Deployment Flow
Vaults and policies are deployed via modules/backupvaults

This module reads vault_name and backup_policy_id dynamically from environment mapping

Auto-enable policies are deployed and assigned at the Management Group

Any newly created VMs matching tags will auto-start backup immediately

🏗️ Architecture Diagram
(You already have a combined Backup + ASR architecture that I gave you earlier — you can reuse that for documentation!)

⚡ Key Benefits
No manual onboarding for backup

Consistent backup across all environments

Vaults and policies automatically mapped

Future environments (like uat, prod2) can be added easily by extending backup_mapping

✅ Completely production-ready
✅ Supports multi-environment setups
✅ Zero hardcoding, full dynamic infra-as-code

📦 Folder Structure
css
Copy
Edit
modules/
  backupvaults/
    main.tf
    outputs.tf
    variables.tf
    policy/
      auto_enable_backup_dev.tf
      auto_enable_backup_qa.tf
      auto_enable_backup_stg.tf
      auto_enable_backup_prd.tf
      outputs.tf
⚙️ To Extend for New Environments (like uat)
Add entry in backup_mapping (tfvars)

Create a copy of auto_enable_backup_uat.tf

Slight update in policy rule (env = "uat")

Done! 🎯

🚨 Important Notes
This module only auto-enables backup for newly created VMs tagged appropriately.

For already existing VMs, manual remediation may be required (Azure Policy won't retro-apply to existing resources without a remediation task).