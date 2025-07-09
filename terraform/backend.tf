
############ Terraform Backend Configuration to Azure Storage Account ###############

terraform {
  backend "azurerm" {
    resource_group_name  = "$(terraformbackendresourcegroup)"
    storage_account_name = "$(terraformbackendstorageaccount)"
    container_name       = "$(terraformbackendstoragecontainer)"
    key                  = "$(terraformstatefilename)"
  }
}