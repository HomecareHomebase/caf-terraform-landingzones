output "objects" {
  value = tomap(
    {
      (var.landingzone.key) = {
        for key, value in module.solution : key => value
        if try(value, {}) != {}
      }
    }
  )
  sensitive = true
}

output "tfstates" {
  value     = local.tfstates
  sensitive = true
}

output "debug_local_global_settings" {
  value = local.global_settings
}