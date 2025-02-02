
module "dynamic_keyvault_secrets" {
  source  = "HomecareHomebase/caf/azurerm//modules/security/dynamic_keyvault_secrets"
  version = "~>100.0.0"

  # source = "git::https://github.com/HomecareHomebase/terraform-azurerm-caf//modules/security/dynamic_keyvault_secrets?ref=feature/brown_field"

  for_each = try(var.dynamic_keyvault_secrets, {})

  settings = each.value
  keyvault = module.caf.keyvaults[each.key]
  objects  = module.caf
}
