resource "azurerm_resource_group" "azure_resource_group" {
  location = var.location

  name = "github-jenkins-${var.product}-${var.env}-rg"

  tags = module.ctags.common_tags
}

module "ctags" {
  source       = "git::https://github.com/hmcts/terraform-module-common-tags.git?ref=master"
  environment  = var.env
  product      = var.product
  builtFrom    = var.builtFrom
  expiresAfter = var.expiresAfter
}