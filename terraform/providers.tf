terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.19.0"
    }
  }
}
provider "azurerm" {
  features {}
  #subscription_id = var.auth_subscription_id
}


######################### Hub Providers      #########################

# Hub Providers
provider "azurerm" {
  features {}
  alias           = "hubcus"
  subscription_id = var.subscription_settings["hubcus"].subscription_id
}

provider "azurerm" {
  features {}
  alias           = "hubwus3"
  subscription_id = var.subscription_settings["hubwus3"].subscription_id
}

######################### Prod Providers      #########################

# Identity Prod Subscription for Central US
provider "azurerm" {
  features {}
  alias           = "iamprdcus"
  subscription_id = var.subscription_settings["iamprdcus"].subscription_id
}

# Identity Prod Subscription for West US3
provider "azurerm" {
  features {}
  alias           = "iamprdwus3"
  subscription_id = var.subscription_settings["iamprdwus3"].subscription_id
}
# Management Prod Subscription for Central US
provider "azurerm" {
  features {}
  alias           = "mgmtprdcus"
  subscription_id = var.subscription_settings["mgmtprdcus"].subscription_id
}
# Management Prod Subscription for West US3
provider "azurerm" {
  features {}
  alias           = "mgmtprdwus3"
  subscription_id = var.subscription_settings["mgmtprdwus3"].subscription_id
}

# EnterpriseOps Prod Subscription for Central US

provider "azurerm" {
  features {}
  alias           = "eopsprdcus"
  subscription_id = var.subscription_settings["eopsprdcus"].subscription_id
}

## EnterpriseOps Prod Subscription for West US3
provider "azurerm" {
  features {}
  alias           = "eopsprdwus3"
  subscription_id = var.subscription_settings["eopsprdwus3"].subscription_id
}

## Surgery Plus Prod Subscription for Central US
provider "azurerm" {
  features {}
  alias           = "splusprdcus"
  subscription_id = var.subscription_settings["splusprdcus"].subscription_id
}
## Surgery Plus Prod Subscription for West US3
provider "azurerm" {
  features {}
  alias           = "splusprdwus3"
  subscription_id = var.subscription_settings["splusprdwus3"].subscription_id
}
## Cancer Care Prod Subscription for Central US 
provider "azurerm" {
  features {}
  alias           = "ccareprdcus"
  subscription_id = var.subscription_settings["ccareprdcus"].subscription_id
}

## Cancet Care Prod Subscription for West US3
provider "azurerm" {
  features {}
  alias           = "ccareprdwus3"
  subscription_id = var.subscription_settings["ccareprdwus3"].subscription_id
}

## Infusion Care Prod Subscription for Central US
provider "azurerm" {
  features {}
  alias           = "icareprdcus"
  subscription_id = var.subscription_settings["icareprdcus"].subscription_id
}

## Infusion Care Prod Subscription for West US3
provider "azurerm" {
  features {}
  alias           = "icareprdwus3"
  subscription_id = var.subscription_settings["icareprdwus3"].subscription_id
}

## DataOps Prod Subscription for Central US  
provider "azurerm" {
  features {}
  alias           = "dataopsprdcus"
  subscription_id = var.subscription_settings["dataopsprdcus"].subscription_id
}

## DataOps Prod Subscription for West US3
provider "azurerm" {
  features {}
  alias           = "dataopsprdwus3"
  subscription_id = var.subscription_settings["dataopsprdwus3"].subscription_id
}

## BusOps Prod Subscription for Central US
provider "azurerm" {
  features {}
  alias           = "busopsprdcus"
  subscription_id = var.subscription_settings["busopsprdcus"].subscription_id
}

## BusOps Prod Subscription for West US3
provider "azurerm" {
  features {}
  alias           = "busopsprdwus3"
  subscription_id = var.subscription_settings["busopsprdwus3"].subscription_id
}



######################### Dev Providers       #########################
## Identity Dev Subscription for Central US
provider "azurerm" {
  features {}
  alias           = "iamdevcus"
  subscription_id = var.subscription_settings["iamdevcus"].subscription_id
}

## Identity Dev Subscription for West US3
provider "azurerm" {
  features {}
  alias           = "iamdevwus3"
  subscription_id = var.subscription_settings["iamdevwus3"].subscription_id
}

## Management Dev Subscription for Central US
provider "azurerm" {
  features {}
  alias           = "mgmtdevcus"
  subscription_id = var.subscription_settings["mgmtdevcus"].subscription_id
}

## Management Dev Subscription for West US3
provider "azurerm" {
  features {}
  alias           = "mgmtdevwus3"
  subscription_id = var.subscription_settings["mgmtdevwus3"].subscription_id
}


## EnterpriseOps Dev Subscription for Central US
provider "azurerm" {
  features {}
  alias           = "eopsdevcus"
  subscription_id = var.subscription_settings["eopsdevcus"].subscription_id
}

## EnterpriseOps Dev Subscription for West US3
provider "azurerm" {
  features {}
  alias           = "eopsdevwus3"
  subscription_id = var.subscription_settings["eopsdevwus3"].subscription_id
}
## Surgery Plus Dev Subscription for Central US
provider "azurerm" {
  features {}
  alias           = "splusdevcus"
  subscription_id = var.subscription_settings["splusdevcus"].subscription_id
}

## Surgery Plus Dev Subscription for West US3
provider "azurerm" {
  features {}
  alias           = "splusdevwus3"
  subscription_id = var.subscription_settings["splusdevwus3"].subscription_id
}

## Cancer Care Dev Subscription for Central US
provider "azurerm" {
  features {}
  alias           = "ccaredevcus"
  subscription_id = var.subscription_settings["ccaredevcus"].subscription_id
}
## Cancer Care Dev Subscription for West US3
provider "azurerm" {
  features {}
  alias           = "ccaredevwus3"
  subscription_id = var.subscription_settings["ccaredevwus3"].subscription_id
}
## Infusion Care Dev Subscription for Central US
provider "azurerm" {
  features {}
  alias           = "icaredevcus"
  subscription_id = var.subscription_settings["icaredevcus"].subscription_id
}

## Cancer Care Dev Subscription for West US3
provider "azurerm" {
  features {}
  alias           = "icaredevwus3"
  subscription_id = var.subscription_settings["icaredevwus3"].subscription_id
}
## DataOps Dev Subscription for Central US
provider "azurerm" {
  features {}
  alias           = "dataopsdevcus"
  subscription_id = var.subscription_settings["dataopsdevcus"].subscription_id
}
## DataOps Dev Subscription for Central US
provider "azurerm" {
  features {}
  alias           = "dataopsdevwus3"
  subscription_id = var.subscription_settings["dataopsdevwus3"].subscription_id
}

## BusOps Dev Subscription for Central US
provider "azurerm" {
  features {}
  alias           = "busopsdevcus"
  subscription_id = var.subscription_settings["busopsdevcus"].subscription_id
}

## BusOps Dev Subscription for West US3

provider "azurerm" {
  features {}
  alias           = "busopsdevwus3"
  subscription_id = var.subscription_settings["busopsdevwus3"].subscription_id
}




######################### QA Providers        #########################

## EnterpriseOps QA Subscription for Central US
provider "azurerm" {
  features {}
  alias           = "eopsqacus"
  subscription_id = var.subscription_settings["eopsqacus"].subscription_id
}

## EnterpriseOps QA Subscription for West US3
provider "azurerm" {
  features {}
  alias           = "eopsqawus3"
  subscription_id = var.subscription_settings["eopsqawus3"].subscription_id
}

## Surgery Plus QA Subscription for Central US
provider "azurerm" {
  features {}
  alias           = "splusqacus"
  subscription_id = var.subscription_settings["splusqacus"].subscription_id
}

## Surgery Plus QA Subscription for West US3
provider "azurerm" {
  features {}
  alias           = "splusqawus3"
  subscription_id = var.subscription_settings["splusqawus3"].subscription_id
}

## Cancer Care QA Subscription for Central US
provider "azurerm" {
  features {}
  alias           = "ccareqacus"
  subscription_id = var.subscription_settings["ccareqacus"].subscription_id
}

## Cancer Care QA Subscription for West US3
provider "azurerm" {
  features {}
  alias           = "ccareqawus3"
  subscription_id = var.subscription_settings["ccareqawus3"].subscription_id
}


## Infusion Care QA Subscription for Central US
provider "azurerm" {
  features {}
  alias           = "icareqacus"
  subscription_id = var.subscription_settings["icareqacus"].subscription_id
}

## Infusion Care QA Subscription for West US3
provider "azurerm" {
  features {}
  alias           = "icareqawus3"
  subscription_id = var.subscription_settings["icareqawus3"].subscription_id
}

## DataOps QA Subscription for Central US
provider "azurerm" {
  features {}
  alias           = "dataopsqacus"
  subscription_id = var.subscription_settings["dataopsqacus"].subscription_id
}

## DataOps Dev Subscription for West US3
provider "azurerm" {
  features {}
  alias           = "dataopsqawus3"
  subscription_id = var.subscription_settings["dataopsqawus3"].subscription_id
}

# BusOps QA Subscription for Central US
provider "azurerm" {
  features {}
  alias           = "busopsqacus"
  subscription_id = var.subscription_settings["busopsqacus"].subscription_id
}

## BusOps QA  Subscription for Central US
provider "azurerm" {
  features {}
  alias           = "busopsqawus3"
  subscription_id = var.subscription_settings["busopsqawus3"].subscription_id
}

######################### Staging Providers   #########################

## EnterpriseOps Staging Subscription for Central US
provider "azurerm" {
  features {}
  alias           = "eopsstgcus"
  subscription_id = var.subscription_settings["eopsstgcus"].subscription_id
}
## EnterpriseOps Staging Subscription for West US3
provider "azurerm" {
  features {}
  alias           = "eopsstgwus3"
  subscription_id = var.subscription_settings["eopsstgwus3"].subscription_id
}

## Surgery Plus Staging Subscription for Central US
provider "azurerm" {
  features {}
  alias           = "splusstgcus"
  subscription_id = var.subscription_settings["splusstgcus"].subscription_id
}
## Surgery Plus Staging Subscription for West US3
provider "azurerm" {
  features {}
  alias           = "splusstgwus3"
  subscription_id = var.subscription_settings["splusstgwus3"].subscription_id
}

## Cancen Care Staging Subscription for Central US
provider "azurerm" {
  features {}
  alias           = "ccarestgcus"
  subscription_id = var.subscription_settings["ccarestgcus"].subscription_id
}

## Cancen Care Staging Subscription for West US3
provider "azurerm" {
  features {}
  alias           = "ccarestgwus3"
  subscription_id = var.subscription_settings["ccarestgwus3"].subscription_id
}

## Infusion Care Staging Subscription for Central US

provider "azurerm" {
  features {}
  alias           = "icarestgcus"
  subscription_id = var.subscription_settings["icarestgcus"].subscription_id
}

## Infusion Care Staging Subscription for West US3
provider "azurerm" {
  features {}
  alias           = "icarestgwus3"
  subscription_id = var.subscription_settings["icarestgwus3"].subscription_id
}

## DatOps Staging Subscription for Central US
provider "azurerm" {
  features {}
  alias           = "dataopsstgcus"
  subscription_id = var.subscription_settings["dataopsstgcus"].subscription_id
}

## DatOps Staging Subscription for West US3
provider "azurerm" {
  features {}
  alias           = "dataopsstgwus3"
  subscription_id = var.subscription_settings["dataopsstgwus3"].subscription_id
}

## BusOps Staging Subscription for Central US
provider "azurerm" {
  features {}
  alias           = "busopsstgcus"
  subscription_id = var.subscription_settings["busopsstgcus"].subscription_id
}

## BusOps Staging Subscription for West US3
provider "azurerm" {
  features {}
  alias           = "busopsstgwus3"
  subscription_id = var.subscription_settings["busopsstgwus3"].subscription_id
}
