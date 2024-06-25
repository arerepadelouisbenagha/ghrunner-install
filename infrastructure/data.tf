data "azurecaf_name" "nic_1" {
  name          = "ce"
  resource_type = "azurerm_network_interface"
  suffixes      = ["tsrlearning", "dev-01"]
  clean_input   = true
  separator     = "-"
}

data "azurecaf_name" "nic_2" {
  name          = "ce"
  resource_type = "azurerm_network_interface"
  suffixes      = ["tsrlearning", "dev-02"]
  clean_input   = true
  separator     = "-"
}

data "azurecaf_name" "nic_3" {
  name          = "ce"
  resource_type = "azurerm_network_interface"
  suffixes      = ["tsrlearning", "dev-03"]
  clean_input   = true
  separator     = "-"
}

data "azurecaf_name" "vm_1" {
  name          = "ce"
  resource_type = "azurerm_linux_virtual_machine"
  suffixes      = ["tsrlearning", "dev-01"]
  clean_input   = true
  separator     = "-"
}

data "azurecaf_name" "vm_2" {
  name          = "ce"
  resource_type = "azurerm_linux_virtual_machine"
  suffixes      = ["tsrlearning", "dev-02"]
  clean_input   = true
  separator     = "-"
}

data "azurecaf_name" "vm_3" {
  name          = "ce"
  resource_type = "azurerm_linux_virtual_machine"
  suffixes      = ["tsrlearning", "dev-03"]
  clean_input   = true
  separator     = "-"
}

# data "vault_generic_secret" "gh_token" {
#   path = "kv/GITHUB-Secrets/"
# }

# data "vault_generic_secret" "password_login" {
#   path = "kv/GITHUB-Secrets/"
# }

# data "vault_generic_secret" "administrator_login_password" {
#   path = "kv/Mysql-secrets-dev"
# }


data "template_file" "custom_data" {
  for_each = local.virtual_machines
  template = file(each.value.custom_data)
  vars     = each.value.vars
}