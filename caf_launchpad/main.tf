terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.50"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 1.4.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 2.2.1"
    }
    external = {
      source  = "hashicorp/external"
      version = "~> 1.2.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "~> 2.1.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "~> 2.2.0"
    }
    azurecaf = {
      source  = "aztfmod/azurecaf"
      version = "~> 1.2.0"
    }
  }
  required_version = ">= 0.13"
}


provider "azurerm" {
  features {}
}

resource "random_string" "prefix" {
  count   = var.prefix == null ? 1 : 0
  length  = 4
  special = false
  upper   = false
  number  = false
}

resource "random_string" "suffix" {
  count   = var.suffix == null ? 1 : 0
  length  = 4
  special = false
  upper   = false
  number  = false
}

locals {
  landingzone_tag = {
    "landingzone" = var.landingzone.key
  }

  tags = merge(local.global_settings.tags, local.landingzone_tag, { "level" = var.landingzone.level }, { "environment" = local.global_settings.environment }, { "rover_version" = var.rover_version }, var.tags)

  suffix = join("-", compact([var.suffix, local.environment_code]))

  global_settings = {
    default_region     = var.default_region
    environment        = var.environment
    inherit_tags       = var.inherit_tags
    passthrough        = var.passthrough
    prefix             = var.prefix
    prefixes           = var.prefix == "" ? null : [try(random_string.prefix.0.result, var.prefix)]
    prefix_with_hyphen = var.prefix == "" ? null : format("%s", try(random_string.prefix.0.result, var.prefix))
    
    suffix             = local.suffix
    suffixes           = local.suffix == "" ? null : try([local.suffix, random_string.suffix.0.result], [local.suffix])
    suffix_with_hyphen = local.suffix == "" ? null : format("%s", try(random_string.suffix.0.result, local.suffix))
    
    random_length      = var.random_length
    regions            = var.regions
    tags               = var.tags
    use_slug           = var.use_slug
  }

  tfstates = map(
    var.landingzone.key,
    local.backend[var.landingzone.backend_type]
  )

  backend = {
    azurerm = {
      storage_account_name = module.launchpad.storage_accounts[var.launchpad_key_names.tfstates[0]].name
      container_name       = module.launchpad.storage_accounts[var.launchpad_key_names.tfstates[0]].containers["tfstate"].name
      resource_group_name  = module.launchpad.storage_accounts[var.launchpad_key_names.tfstates[0]].resource_group_name
      key                  = var.tf_name
      level                = var.landingzone.level
      tenant_id            = data.azurerm_client_config.current.tenant_id
      subscription_id      = data.azurerm_client_config.current.subscription_id
    }
  }

  environment_codes = {
    Local             = "locl",
    Development       = "dev",
    QA-Hotfix         = "qahf",
    Automation-Hotfix = "auhf",
    QA-Odd            = "qaod",
    Automation-Odd    = "auod",
    QA-Even           = "qaev",
    Automation-Even   = "auev",
    Staging           = "stg",
    Training          = "trn",
    Pilot             = "plt",
    Pilot-Hotfix      = "plth",
    Pilot-Staging     = "plts",
    Production        = "prd",
    Non-Production    = "nprd",
    Pipeline          = "ppl"
  }

  environment_code = lookup(local.environment_codes, var.environment)
}

data "azurerm_client_config" "current" {}