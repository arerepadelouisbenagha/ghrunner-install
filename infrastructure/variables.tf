variable "client_id" {
  description = "(Optional) The Client ID which should be used. This can also be sourced from the ARM_CLIENT_ID Environment Variable."
  type        = string
  default     = "b26145ad-4bdc-4af7-bc86-8dc3d89e9d4e"
}

variable "subscription_id" {
  description = "(Optional) The Subscription ID which should be used. This can also be sourced from the ARM_SUBSCRIPTION_ID Environment Variable."
  type        = string
  default     = "f823a9e2-b296-41ab-b452-5f2c01eefae8"
}

variable "tenant_id" {
  description = "(Optional) The Tenant ID which should be used. This can also be sourced from the ARM_TENANT_ID Environment Variable."
  type        = string
  default     = "389dc11c-508a-4f1e-a529-1f19aa1a8e7b"
}

variable "client_secret" {
  description = "(Optional) The Client Secret which should be used. This can also be sourced from the ARM_CLIENT_SECRET Environment Variable."
  type        = string
}

variable "vm_username" {
  type        = string
  description = "VM username for login"
  default     = "tsrlearning"
}

variable "private_key" {
  type = string
}

variable "public_key" {
  type = string
}

variable "custom_data_vm_1" {
  description = "Path to the custom data script for VM initialization"
  type        = string
}

variable "GH_PAT_TOKEN" {
  type = string
  description = "The Github access pat-token"
}