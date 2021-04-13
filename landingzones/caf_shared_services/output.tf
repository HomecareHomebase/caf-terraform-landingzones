output global_settings {
  value     = local.global_settings
  sensitive = true
}

output diagnostics {
  value     = local.diagnostics
  sensitive = true
}

output tfstates {
  value     = local.tfstates
  sensitive = true
}

output managed_identities {
  value      = tomap({
    (var.landingzone.key) = try(local.remote.managed_identities["foundations"], {})
  })
  sensitive = true

  depends_on = [
    data.terraform_remote_state.remote
  ]
}
output azuread_groups {
  value     = local.remote.azuread_groups
  sensitive = true
}

output recovery_vaults {
  value = tomap({
    (var.landingzone.key) = module.landingzones_shared_services.recovery_vaults
  })
}

output custom_role_definitions {
  value     = local.remote.custom_role_definitions
  sensitive = true
}

output azure_container_registries {
  value     = local.combined.azure_container_registries
  sensitive = true
}