#
# microsoft_enterprise_cloud_monitoring - Install the monitoring agent in the virtual machine
#


module "vm_extension_monitoring_agent" {
  source  = "git::https://github.com/HomecareHomebase/terraform-azurerm-caf//modules/compute/virtual_machine_extensions?ref=feature/brown_field"

  for_each = {
    for key, value in try(var.virtual_machines, {}) : key => value
    if try(value.virtual_machine_extensions.microsoft_enterprise_cloud_monitoring, null) != null
  }

  client_config      = module.landingzones_shared_services.client_config
  virtual_machine_id = module.landingzones_shared_services.virtual_machines[each.key].id
  extension          = each.value.virtual_machine_extensions.microsoft_enterprise_cloud_monitoring
  extension_name     = "microsoft_enterprise_cloud_monitoring"
  settings = {
    diagnostics = local.diagnostics
  }
}

module "vm_extension_diagnostics" {
  source  = "git::https://github.com/HomecareHomebase/terraform-azurerm-caf//modules/compute/virtual_machine_extensions?ref=feature/brown_field"

  for_each = {
    for key, value in try(var.virtual_machines, {}) : key => value
    if try(value.virtual_machine_extensions.microsoft_azure_diagnostics, null) != null
  }

  client_config      = module.landingzones_shared_services.client_config
  virtual_machine_id = module.landingzones_shared_services.virtual_machines[each.key].id
  extension          = each.value.virtual_machine_extensions.microsoft_azure_diagnostics
  extension_name     = "microsoft_azure_diagnostics"
  settings = {
    diagnostics                      = local.diagnostics
    xml_diagnostics_file             = try(each.value.virtual_machine_extensions.microsoft_azure_diagnostics.xml_diagnostics_file, null)
    diagnostics_storage_account_keys = each.value.virtual_machine_extensions.microsoft_azure_diagnostics.diagnostics_storage_account_keys
  }
}
