data "azurerm_resource_group" "rg" {
  name = "github-jenkins-${var.project}-${var.env}-rg"
}

data "azurerm_key_vault" "example" {
  name                = var.cft_key_vault_name
  resource_group_name = var.cft_key_vault_rg_name
}
