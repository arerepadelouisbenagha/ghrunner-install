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
