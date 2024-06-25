resource "azurerm_network_security_rule" "ssh_rule" {
  name                        = "SSHRule"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "143.55.59.117/32"
  destination_address_prefix  = "*"
  description                 = "NSG used for SSH login to Linux Server"
  resource_group_name         = module.resource_group.rg_name
  network_security_group_name = module.subnet.nsg_name
}
