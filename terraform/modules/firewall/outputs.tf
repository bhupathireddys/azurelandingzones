output "firewall_id" {
  value = azurerm_firewall.hub_fw.id
}

output "firewall_private_ip" {
  value = azurerm_firewall.hub_fw.ip_configuration[0].private_ip_address
}

output "firewall_public_ip" {
  value = azurerm_public_ip.fw.ip_address
}

output "management_public_ip" {
  value = azurerm_public_ip.fw_mgmt.ip_address
}
