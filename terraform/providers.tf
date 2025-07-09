terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.33.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = var.auth_subscription_id

  # tenant_id         = "${tenant_id}"
  # client_id         = "${client_id}"
  # client_secret     = "${client_secret}"
  # subscription_id   = "${subscription_id}"
}

# IAM Provider (for prd environment)
provider "azurerm" {
  features {}
  alias           = "iamprd"
  subscription_id = var.subscription_settings["iamprd"].subscription_id
}

# mgmt Provider (for prd environment)
provider "azurerm" {
  features {}
  alias           = "mgmtprd"
  subscription_id = var.subscription_settings["mgmtprd"].subscription_id
}

