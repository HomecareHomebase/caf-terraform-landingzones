output "debug_local_global_settings" {
  value = local.global_settings
}

output "debug_services_roles" {
    value = module.solution.debug_local_services_roles
}