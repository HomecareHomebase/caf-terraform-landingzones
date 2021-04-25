output "debug" {
  value = tomap( {
    "global_settings" = local.global_settings,
    "caf" = module.solution.debug,
  })
  sensitive = true
}