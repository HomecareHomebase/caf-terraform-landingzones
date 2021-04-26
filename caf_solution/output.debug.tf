output "debug_caf_local_services_roles" {
  value = module.solution.debug_local_services_roles
  sensitive = true
}

output "debug_caf_local_combined_objects_managed_identities" {
  value = module.solution.debug_local_combined_objects_managed_identities
  sensitive = true
}