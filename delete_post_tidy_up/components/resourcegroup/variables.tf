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
