output "nat_gateway_id" {
  value = var.enable_firewall ? null : try(azurerm_nat_gateway.natgw[0].id, null)
}

output "nat_gateway_public_ip" {
  value = var.enable_firewall ? null : try(azurerm_public_ip.natgw_ip[0].ip_address, null)
}
