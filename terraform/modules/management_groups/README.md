# Azure Management Groups Module

This Terraform module provisions an Azure Management Group hierarchy up to three layers (root, layer1, layer2, layer3) and assigns subscriptions at each level where specified.

---

## 📌 Features

- Creates a **Root Management Group**.
- Supports nested **Layer 1, 2, and 3** management groups.
- Allows assignment of **subscriptions** to each management group level.
- Supports flexible, optional subscription association (can just create groups without assigning subscriptions).

---

## 🏗️ Hierarchy Overview

Root Management Group (e.g., Contoso)
├── LandingZones (Layer 1)
│ ├── Identity (Layer 2)
│ │ └── IAM-PRD, IAM-DEV, etc. (Layer 3)
│ ├── Management
│ ├── Connectivity
│ └── Security
└── Applications
├── EOPS
└── SPLUS


---

## 🔧 Module Inputs

| Name                         | Type     | Description                                             | Required |
|------------------------------|----------|---------------------------------------------------------|----------|
| `root_management_group_name` | `string` | Display name for the root management group              | ✅ Yes   |
| `layer1_management_group_names` | `map(object)` | Layer 1 group names and optional subscription IDs       | ✅ Yes   |
| `layer2_management_group_names` | `map(object)` | Layer 2 group names, parent, and optional subscriptions | ✅ Yes   |
| `layer3_management_group_names` | `map(object)` | Layer 3 group names, parent, and optional subscriptions | ✅ Yes   |

> 💡 `subscription_ids` is optional at each layer. Use `null` or skip to create groups only.

---

## 🧾 Sample Input (`terraform.tfvars`)

```hcl
root_management_group_name = "Contoso"

layer1_management_group_names = {
  "LandingZones" = {
    subscription_ids = null
  }
  "Applications" = {
    subscription_ids = null
  }
}

layer2_management_group_names = {
  "Identity" = {
    parent_management_group = "LandingZones"
    subscription_ids = null
  }
  "EOPS" = {
    parent_management_group = "Applications"
    subscription_ids = ["sub-id-eops-dev", "sub-id-eops-prd"]
  }
}

layer3_management_group_names = {
  "IAM-PRD" = {
    parent_management_group = "Identity"
    subscription_ids = ["sub-id-iam-prd"]
  }
  "IAM-DEV" = {
    parent_management_group = "Identity"
    subscription_ids = ["sub-id-iam-dev"]
  }
}


📤 Module Outputs
Output Name	Description
root_management_group	Root group's name, display_name, and ID
layer1_management_groups	Map of layer1 groups with details
layer2_management_groups	Map of layer2 groups with details
layer3_management_groups	Map of layer3 groups with details

✅ Usage in Root Module

module "management_groups" {
  source = "./modules/management_groups"

  root_management_group_name    = var.root_management_group_name
  layer1_management_group_names = var.layer1_management_group_names
  layer2_management_group_names = var.layer2_management_group_names
  layer3_management_group_names = var.layer3_management_group_names
}
