
module "dynamic_keyvault_secrets" {
  source  = "git::https://github.com/HomecareHomebase/terraform-azurerm-caf//modules/security/dynamic_keyvault_secrets?ref=backup/merge/20210516"

  for_each = try(var.dynamic_keyvault_secrets, {})

  settings = each.value
  keyvault = module.launchpad.keyvaults[each.key]
  objects  = module.launchpad
}
