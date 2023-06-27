data "azurerm_managed_api" "api" {
  name     = "servicebus"
  location = var.location
}

resource "azurerm_api_connection" "connection" {
  name                = "github-sb-jenkins-con"
  resource_group_name = data.azurerm_resource_group.rg.name
  managed_api_id      = data.azurerm_managed_api.api.id

  parameter_values = {
    connectionString = module.servicebus-namespace.default_primary_connection_string
  }

  tags = module.ctags.common_tags

  lifecycle {
    
    ignore_changes = ["parameter_values"]
  }
}