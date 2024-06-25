provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
  client_id       = var.client_id
  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id
  client_secret   = var.client_secret
}


# variable "login_username" {
#   type    = string
#   default = "tsrlearning"
# }

# variable "login_password" {
#   type = string
# }

# provider "vault" {
#   auth_login {
#     path = "auth/userpass/login/${var.login_username}"

#     parameters = {
#       password = var.login_password #data.vault_generic_secret.password_login.data["LOGIN-PASSWORD"]
#     }
#   }
#   address = "http://${azurerm_public_ip.vm_2.ip_address}:8200"
# }