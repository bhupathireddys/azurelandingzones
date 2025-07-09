resource "azurerm_policy_definition" "require_tag_phidata" {
  name                = "require-tag-phidata"
  policy_type         = "Custom"
  mode                = "Indexed"
  management_group_id = var.tag_settings.management_group_id
  display_name        = "Enforce 'phidata' Tag on Production Storage, App Services, and Databases"
  description         = "Deny creation of prod resources (storage, app services, dbs) if 'phidata' tag is missing or not in ['Yes', 'No', 'Unknown']"

  policy_rule = jsonencode({
    "if": {
      "allOf": [
        { "field": "tags['env']", "equals": "prd" },
        {
          "anyOf": [
            { "field": "type", "equals": "Microsoft.Storage/storageAccounts" },
            { "field": "type", "equals": "Microsoft.Web/sites" },
            { "field": "type", "equals": "Microsoft.Sql/servers" },
            { "field": "type", "equals": "Microsoft.DBforPostgreSQL/servers" },
            { "field": "type", "equals": "Microsoft.DBforMySQL/servers" },
            { "field": "type", "equals": "Microsoft.DocumentDB/databaseAccounts" }
          ]
        },
        {
          "anyOf": [
            { "field": "tags['phidata']", "exists": "false" },
            { "field": "tags['phidata']", "notIn": ["Yes", "No", "Unknown"] }
          ]
        }
      ]
    },
    "then": {
      "effect": "Deny"
    }
  })

  metadata = jsonencode({
    category = "Tags",
    version  = "1.0.0"
  })
}
