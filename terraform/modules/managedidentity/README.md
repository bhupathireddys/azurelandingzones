# Identity Module

This module creates a user-assigned managed identity and assigns the following roles:
- Contributor
- Resource Policy Contributor

## Inputs

| Name                  | Description                                              | Type   | Required |
|-----------------------|----------------------------------------------------------|--------|----------|
| identity_name         | Name of the User Assigned Managed Identity               | string | yes      |
| identity_location     | Azure region for the managed identity                    | string | yes      |
| identity_resource_group | Name of the resource group for the identity            | string | yes      |
| assignment_scope      | Scope where the identity will be assigned roles         | string | yes      |

## Outputs

| Name                   | Description                             |
|------------------------|-----------------------------------------|
| policy_uami_id         | The full resource ID of the identity    |
| policy_uami_client_id  | The client ID of the identity           |
| policy_uami_principal_id | The principal ID of the identity     |

## Example Usage

```hcl
module "identity" {
  source                   = \"./modules/identity\"
  identity_name            = \"uami-govern\"
  identity_location        = \"centralus\"
  identity_resource_group  = \"rg-identity\"
  assignment_scope         = \"/providers/Microsoft.Management/managementGroups/my-root-mg\"
}
