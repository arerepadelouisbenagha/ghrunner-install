output "vm_1" {
  value = azurerm_public_ip.vm_1.ip_address
}

# output "vm_2" {
#   value = module.virtual_network.ip_address
# }

# output "vm_3" {
#   value = azurerm_public_ip.vm_3.ip_address
# }

# output "vault_url" {
#   value = "http://${azurerm_public_ip.vm_2.ip_address}:8200"
# }