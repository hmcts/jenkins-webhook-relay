module "servicebus-namespace" {
    providers = {
    azurerm.private_endpoint = azurerm.private_endpoint
  }
  source                  = "git::https://github.com/hmcts/terraform-module-servicebus-namespace?ref=master"
  name                    = "${var.product}-${var.component}"
  resource_group_name     = data.azurerm_resource_group.rg.name
  location                = var.location
  env                     = var.env
  common_tags             = module.ctags.common_tags
  project                 = var.project
  enable_private_endpoint = var.servicebus_enable_private_endpoint
  zone_redundant          = true
}

module "ctags" {
  source       = "git::https://github.com/hmcts/terraform-module-common-tags.git?ref=master"
  environment  = var.env
  product      = var.product
  builtFrom    = var.builtFrom
  expiresAfter = var.expiresAfter
}