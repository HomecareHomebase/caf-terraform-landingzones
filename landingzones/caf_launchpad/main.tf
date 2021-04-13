terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.52.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 1.4.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.1.0"
    }
    external = {
      source  = "hashicorp/external"
      version = "~> 2.1.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "~> 3.1.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "~> 3.1.0"
    }
    azurecaf = {
      source  = "aztfmod/azurecaf"
      version = "~> 1.2.0"
    }
  }
  required_version = ">= 0.14"
}


provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy = true
    }
  }
}


resource "random_string" "prefix" {
  length  = 4
  special = false
  upper   = false
  number  = false
}

resource "random_string" "suffix" {
  length  = 4
  special = false
  upper   = false
  number  = false
}

resource "random_string" "alpha1" {
  length  = 1
  special = false
  upper   = false
  number  = false
}

locals {
  landingzone_tag = {
    landingzone = var.landingzone.key
  }
  tags = merge(local.landingzone_tag, { "level" = var.landingzone.level }, { "environment" = var.environment }, { "rover_version" = var.rover_version }, var.tags)

  prefix = var.prefix == null ? random_string.prefix.result : var.prefix
  suffix = var.suffix == null ? random_string.suffix.result : var.suffix

  global_settings = {
    prefix             = local.prefix
    prefix_with_hyphen = local.prefix == "" ? "" : "${local.prefix}-"
    prefix_start_alpha = local.prefix == "" ? "" : "${random_string.alpha1.result}${local.prefix}"
    suffix = format("%s-%s", local.environment_code, local.suffix)
    suffix_with_hyphen = local.suffix == "" ? "" : "-${local.suffix}"
    suffix_start_alpha = local.suffix == "" ? "" : "${random_string.alpha1.result}${local.suffix}"
    default_region     = var.default_region
    environment        = var.environment
    regions            = var.regions
    passthrough        = var.passthrough
    random_length      = var.random_length
    inherit_tags       = var.inherit_tags
    use_slug           = var.use_slug
    tags               = var.tags
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