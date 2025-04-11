locals {
  region_short = var.regions_short[var.subscription_settings.region]
  parent_cidr  = var.subscription_settings.cidr

  subnet_cidrs = cidrsubnets(
    local.parent_cidr,
    5, 5, 5, 6, 6 # /26, /26, /26, /27, /27
  )

  subnets = {
    bastion        = { name = "AzureBastionSubnet", cidr = local.subnet_cidrs[0] },
    firewall       = { name = "AzureFirewallSubnet", cidr = local.subnet_cidrs[1] },
    firewall-mgmt  = { name = "AzureFirewallManagementSubnet", cidr = local.subnet_cidrs[2] },
    gateway        = { name = "GatewaySubnet", cidr = local.subnet_cidrs[3] },
    private-endpoint = { name = "PrivateEndpointSubnet", cidr = local.subnet_cidrs[4] }
  }
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
  for_each = local.subnets

  name                 = each.value.name
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [each.value.cidr]
}

# Always create route table first (intra-vnet route only)
resource "azurerm_route_table" "hub_rt" {
  name                = "${var.subscription_settings.root_id}-${local.region_short}-${var.subscription_settings.workload}-${var.subscription_settings.env}-rt"
  location            = var.subscription_settings.region
  resource_group_name = azurerm_resource_group.rg.name

  route {
    name           = "intra-vnet"
    address_prefix = var.subscription_settings.cidr
    next_hop_type  = "VnetLocal"
  }
}

# Subnet route table association (Private Endpoint Subnet)
resource "azurerm_subnet_route_table_association" "private_endpoint" {
  subnet_id      = azurerm_subnet.subnets["private-endpoint"].id
  route_table_id = azurerm_route_table.hub_rt.id
}

# Add default route to Firewall AFTER Firewall is created
resource "azurerm_route" "fw_default" {
  count                   = var.enable_firewall ? 1 : 0
  name                    = "fw-default"
  resource_group_name     = azurerm_resource_group.rg.name
  route_table_name        = azurerm_route_table.hub_rt.name
  address_prefix          = "0.0.0.0/0"
  next_hop_type           = "VirtualAppliance"
  next_hop_in_ip_address  = var.firewall_private_ip
  depends_on              = [azurerm_route_table.hub_rt]
}
