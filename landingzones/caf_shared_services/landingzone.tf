module "landingzones_shared_services" {
  source  = "git::https://github.com/HomecareHomebase/terraform-azurerm-caf?ref=feature/brown_field"

  current_landingzone_key = var.landingzone.key
  tenant_id               = var.tenant_id
  tags                    = local.tags
  diagnostics             = local.diagnostics
  global_settings         = local.global_settings
  tfstates                = local.tfstates
  logged_user_objectId    = var.logged_user_objectId
  logged_aad_app_objectId = var.logged_aad_app_objectId
  resource_groups         = var.resource_groups
  resource_group_datas    = var.resource_group_datas
  role_mapping            = var.role_mapping

  shared_services = {
    recovery_vaults = var.recovery_vaults
    automations     = var.automations
  }

  compute = {
    virtual_machines = var.virtual_machines
    azure_container_registries     = var.azure_container_registries
    azure_container_registry_datas = var.azure_container_registry_datas
  }

  # Pass the remote objects you need to connect to.
  remote_objects = {
    managed_identities               = local.remote.managed_identities
    vnets                            = local.remote.vnets
    keyvaults                        = local.remote.keyvaults
    recovery_vaults                  = local.remote.recovery_vaults
  }
}