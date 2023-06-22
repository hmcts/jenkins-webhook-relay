variable "subscription_id" {
  description = "Enter Azure subscription id."
}

variable "location" {
  description = "Enter Azure location."
  default     = "UK South"
}

variable "env" {
  description = "Enter the environment. eg prod, aat"
}

variable "product" {
  description = "The name of the product."
}

variable "builtFrom" {
  description = "The name of the Github repo."
}

variable "expiresAfter" {
  description = "Expiration date"
  default     = "3000-01-01"
}

variable "project" {
  description = "The name of the project."
}

variable "cft_key_vault_name" {
  description = "Name of the keyvault in CFT to storage secrets"
}
variable "cft_key_vault_rg_name" {
  description = "Name of the keyvault resource group in CFT"
}

variable "enable_workflow" {
  description = "Enable workflow"
  default = true
}