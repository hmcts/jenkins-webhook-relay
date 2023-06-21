module "servicebus-queue" {
  source              = "git@github.com:hmcts/terraform-module-servicebus-queue?ref=master"
  name                = var.queue_name
  namespace_name      = module.servicebus-namespace.name
  resource_group_name = azurerm_resource_group.rg.name
}