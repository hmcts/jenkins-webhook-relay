resource "azurerm_logic_app_workflow" "logic_app_workflow" {
  name                = "github-jenkins-${var.env}"
  enabled             = var.enable_workflow
  location            = var.location
  resource_group_name = data.azurerm_resource_group.rg.name

  identity {
    type = "SystemAssigned"
  }

  tags = module.ctags.common_tags
}

module "ctags" {
  source       = "git::https://github.com/hmcts/terraform-module-common-tags.git?ref=master"
  environment  = var.env
  product      = var.product
  builtFrom    = var.builtFrom
  expiresAfter = var.expiresAfter
}