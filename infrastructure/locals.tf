locals {
  common_tags = {
    CompanyName = "TSR Learning"
    CohortBatch = "Cloud Engineering"
    Provider    = "Azure Cloud"
    ManagedWith = "Terraform"
    casecode    = "tsr2024"
  }
  custom_data_vm_1 = var.custom_data_vm_1

  virtual_machines = {
    vm-1 = {
      name           = "ghrunner-vm-01"
      size           = "Standard_F2"
      admin_username = "tsrlearning"
      username       = "tsrlearning"
      public_key     = var.public_key
      custom_data    = local.custom_data_vm_1
      vars = {
        RUNNER_URL = "https://github.com/actions/runner/releases/download/v2.317.0/actions-runner-linux-x64-2.317.0.tar.gz"
        RUNNER_SHA = "9e883d210df8c6028aff475475a457d380353f9d01877d51cc01a17b2a91161d"
        RUNNER_TAR = "./actions-runner-linux-x64-2.317.0.tar.gz"
        GH_PAT_TOKEN      = var.GH_PAT_TOKEN
      }
    }
  }
  network_interface_ids = {
    vm-1 = {
      name                 = data.azurecaf_name.nic_1.result
      public_ip_address_id = azurerm_public_ip.vm_1.id
      subnet_id            = module.subnet.snet_id
    }
  }
}
