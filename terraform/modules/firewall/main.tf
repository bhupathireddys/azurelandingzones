locals {
  region_short = var.regions_short[var.subscription_settings.region]
}

resource "azurerm_public_ip" "fw" {
  name                = "${var.root_id}-${local.region_short}-AZFW-PIP"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_public_ip" "fw_mgmt" {
  name                = "${var.root_id}-${local.region_short}-AZFW-Mgmt-PIP"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_firewall" "hub_fw" {
  name                = "${var.root_id}-${local.region_short}-AZFW_VNet"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku_name            = "AZFW_VNet"
  sku_tier            = var.sku_tier

  ip_configuration {
    name                 = "client-config"
    subnet_id            = var.firewall_subnet_id
    public_ip_address_id = azurerm_public_ip.fw.id
  }

  management_ip_configuration {
    name                 = "management-config"
    subnet_id            = var.management_subnet_id
    public_ip_address_id = azurerm_public_ip.fw_mgmt.id
  }
}
