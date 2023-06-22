resource "azurerm_logic_app_workflow" "logic_app_workflow" {
  name                = "github-jenkins-${var.env}" 
  enabled             = var.enable_workflow 
  location            = var.location
  resource_group_name = data.azurerm_resource_group.rg.name

  identity {
    type = "SystemAssigned"
  }

  tags = module.tags.common_tags
}

