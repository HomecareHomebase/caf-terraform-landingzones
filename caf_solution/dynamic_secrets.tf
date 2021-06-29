module "dynamic_keyvault_secrets" {
  source  = "HomecareHomebase/caf/azurerm//modules/security/dynamic_keyvault_secrets"
  version = "~>100.0.0"

  # source = "git::https://github.com/HomecareHomebase/terraform-azurerm-caf//modules/security/dynamic_keyvault_secrets?ref=feature/brown_field"

  for_each = {
    for keyvault_key, secrets in try(var.dynamic_keyvault_secrets, {}) : keyvault_key => {
      for key, value in secrets : key => value
      if try(value.value, null) == null
    }
  }

  settings = each.value
  keyvault = module.solution.keyvaults[each.key]
  objects  = module.solution
}