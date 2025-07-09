resource "azurerm_policy_definition" "require_tag_backup_disasterrecovery" {
  name                = "auto-set-backup-dr-tags"
  policy_type         = "Custom"
  mode                = "Indexed"
  management_group_id = var.tag_settings.management_group_id
  display_name        = "Auto-Set Backup and DR Tags Based on Environment"
  description         = "Auto-assign 'backup' and 'disasterrecovery' tags as Yes/No based on env"

  policy_rule = jsonencode({
    if = {
      allOf = [
        {
          field     = "type"
          notEquals = "Microsoft.Resources/subscriptions/resourceGroups"
        },
        {
          anyOf = [
            {
              allOf = [
                { field = "tags['env']", equals = "prd" },
                {
                  anyOf = [
                    { field = "tags['backup']", exists = "false" },
                    { field = "tags['disasterrecovery']", exists = "false" }
                  ]
                }
              ]
            },
            {
              allOf = [
                {
                  anyOf = [
                    { field = "tags['env']", equals = "dev" },
                    { field = "tags['env']", equals = "qa" },
                    { field = "tags['env']", equals = "stg" }
                  ]
                },
                {
                  anyOf = [
                    { field = "tags['backup']", exists = "false" },
                    { field = "tags['disasterrecovery']", exists = "false" }
                  ]
                }
              ]
            }
          ]
        }
      ]
    },
    then = {
      effect = "modify",
      details = {
        roleDefinitionIds = [
          "/providers/Microsoft.Authorization/roleDefinitions/b24988ac-6180-42a0-ab88-20f7382dd24c"
        ],
        operations = [
          {
            operation = "addOrReplace",
            field     = "tags['backup']",
            value     = "[if(equals(field('tags[\"env\"]'), 'prd'), 'Yes', 'No')]"
          },
          {
            operation = "addOrReplace",
            field     = "tags['disasterrecovery']",
            value     = "[if(equals(field('tags[\"env\"]'), 'prd'), 'Yes', 'No')]"
          }
        ]
      }
    }
  })

  metadata = jsonencode({
    category = "Tags"
    version  = "1.0.0"
  })
}
