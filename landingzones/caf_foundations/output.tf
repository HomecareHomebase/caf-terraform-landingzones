output global_settings {
  value     = local.global_settings
  sensitive = true
}
output diagnostics {
  value     = module.foundations.diagnostics
  sensitive = true
}
output vnets {
  value     = local.remote.vnets
  sensitive = true
}
output tfstates {
  value     = local.tfstates
  sensitive = true
}
output keyvaults {
  value = tomap({
    (var.landingzone.key) = try(module.foundations.keyvaults, {})
  })
  sensitive = true
}
# Active Directory
output managed_identities {
  value = local.combined.managed_identities
  sensitive = true
}
output azuread_groups {
  value = local.combined.azuread_groups
  sensitive = true
}
output aad_apps {
  value = local.combined.aad_apps
  sensitive = true
}
output azuread_users {
  value = local.combined.managed_identities
  sensitive = true
}

output custom_role_definitions {
  value = local.combined.custom_role_definitions
  sensitive = true
}

# Debugging

output debug_resource_groups {
  value = module.foundations.resource_groups
  sensitive = true
}

output debug_roles_to_process {
  value = module.foundations.roles_to_process
  sensitive = true
}

output debug_azuread_groups_members_local_managed_identities_to_process {
  value = module.foundations.debug_azuread_groups_members_local_managed_identities_to_process
}