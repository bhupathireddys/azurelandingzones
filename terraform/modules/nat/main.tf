resource "azurerm_public_ip" "natgw_ip" {
  name                = "${var.root_id}-${var.env}-${var.region_short}-natgw-ip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
  count               = var.enable_firewall ? 0 : 1
}

resource "azurerm_nat_gateway" "natgw" {
  name                = "${var.root_id}-${var.env}-${var.region_short}-natgw"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku_name            = "Standard"
  idle_timeout_in_minutes = 10
  count               = var.enable_firewall ? 0 : 1
}

resource "azurerm_nat_gateway_public_ip_association" "natgw_assoc" {
  nat_gateway_id       = try(azurerm_nat_gateway.natgw[0].id, null)
  public_ip_address_id = try(azurerm_public_ip.natgw_ip[0].id, null)
  count                = var.enable_firewall ? 0 : 1
}
