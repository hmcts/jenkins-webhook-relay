module "servicebus-queue" {
  source              = "git::https://github.com/hmcts/terraform-module-servicebus-queue?ref=master"
  name                = var.queue_name
  namespace_name      = module.servicebus-namespace.name
  resource_group_name = data.azurerm_resource_group.rg.name
}