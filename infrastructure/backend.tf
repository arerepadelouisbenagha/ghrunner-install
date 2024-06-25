terraform {
  backend "azurerm" {
    resource_group_name  = "rg-tsrlearning-state"
    storage_account_name = "tsrlearningstor"
    container_name       = "terraformstate"
    key                  = "prod.terraform.tfstate"
  }
}
