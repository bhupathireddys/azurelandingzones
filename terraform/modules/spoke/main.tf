locals {
  region_short = var.regions_short[var.subscription_settings.region]
  parent_cidr  = var.subscription_settings.cidr

  subnets = [
    { name = "web", newbits = 3 },
    { name = "app", newbits = 3 },
    { name = "db", newbits = 3 },
    { name = "private-endpoint", newbits = 6 }
  ]

  subnet_cidrs = cidrsubnets(local.parent_cidr, [for s in local.subnets : s.newbits]...)
}

resource "azurerm_resource_group" "rg" {
  name     = "${var.subscription_settings.root_id}-${local.region_short}-${var.subscription_settings.workload}-${var.subscription_settings.env}-rg"
  location = var.subscription_settings.region
}

resource "azurerm_virtual_network" "vnet" {
  name                = "${var.subscription_settings.root_id}-${local.region_short}-${var.subscription_settings.workload}-${var.subscription_settings.env}-vnet"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.subscription_settings.region
  address_space       = [var.subscription_settings.cidr]
}

resource "azurerm_subnet" "subnets" {
  for_each = { for s in local.subnets : s.name => s }

  name                 = "${var.subscription_settings.root_id}-${local.region_short}-${var.subscription_settings.workload}-${each.value.name}-subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [local.subnet_cidrs[index(local.subnets, each.value)]]
}

resource "azurerm_route_table" "spoke_rt" {
  name                = "${var.subscription_settings.root_id}-${local.region_short}-${var.subscription_settings.workload}-${var.subscription_settings.env}-spoke-rt"
  location            = var.subscription_settings.region
  resource_group_name = azurerm_resource_group.rg.name

  route {
    name           = "intra-vnet"
    address_prefix = var.subscription_settings.cidr
    next_hop_type  = "VnetLocal"
  }

  dynamic "route" {
    for_each = var.enable_firewall ? [1] : []
    content {
      name                   = "primary-route"
      address_prefix         = "0.0.0.0/1"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = var.primary_hub_fw_ip
    }
  }

  dynamic "route" {
    for_each = var.enable_firewall ? [1] : []
    content {
      name                   = "failover-route"
      address_prefix         = "128.0.0.0/1"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = var.secondary_hub_fw_ip
    }
  }
}

resource "azurerm_subnet_route_table_association" "subnet_assoc" {
  for_each = azurerm_subnet.subnets
  subnet_id   = each.value.id
  route_table_id = azurerm_route_table.spoke_rt.id
}

# NAT Gateway in spoke (only when firewall = false)
resource "azurerm_public_ip" "natgw_ip" {
  count               = var.enable_firewall ? 0 : 1
  name                = "${var.subscription_settings.root_id}-${local.region_short}-${var.subscription_settings.workload}-${var.subscription_settings.env}-natgw-ip"
  location            = var.subscription_settings.region
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_nat_gateway" "natgw" {
  count               = var.enable_firewall ? 0 : 1
  name                = "${var.subscription_settings.root_id}-${local.region_short}-${var.subscription_settings.workload}-${var.subscription_settings.env}-natgw"
  location            = var.subscription_settings.region
  resource_group_name = azurerm_resource_group.rg.name
  sku_name            = "Standard"
}

resource "azurerm_nat_gateway_public_ip_association" "natgw_assoc" {
  count                = var.enable_firewall ? 0 : 1
  nat_gateway_id       = azurerm_nat_gateway.natgw[0].id
  public_ip_address_id = azurerm_public_ip.natgw_ip[0].id
}

resource "azurerm_subnet_nat_gateway_association" "nat_assoc" {
  for_each    = var.enable_firewall ? {} : azurerm_subnet.subnets
  subnet_id   = each.value.id
  nat_gateway_id = azurerm_nat_gateway.natgw[0].id
}
