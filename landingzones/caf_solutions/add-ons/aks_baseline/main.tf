terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.49"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.0"
    }
    flux = {
      source = "fluxcd/flux"
      version = "~> 0.1"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = "~> 1.10"
    }
  }

  required_version = ">= 0.14"
}


provider "azurerm" {
  features {
  }
}

provider "kubernetes" {
  host                   = try(local.k8sconfigs[0].host, null)
  username               = try(local.k8sconfigs[0].username, null)
  password               = try(local.k8sconfigs[0].password, null)
  client_certificate     = try(local.k8sconfigs[0].client_certificate, null)
  client_key             = try(local.k8sconfigs[0].client_key, null)
  cluster_ca_certificate = try(local.k8sconfigs[0].cluster_ca_certificate, null)
  alias                  = "k8s1"
}

provider "helm" {
  kubernetes {
    host                   = try(local.k8sconfigs[0].host, null)
    username               = try(local.k8sconfigs[0].username, null)
    password               = try(local.k8sconfigs[0].password, null)
    client_certificate     = try(local.k8sconfigs[0].client_certificate, null)
    client_key             = try(local.k8sconfigs[0].client_key, null)
    cluster_ca_certificate = try(local.k8sconfigs[0].cluster_ca_certificate, null)
  }
  alias = "helm1"
}

provider "kubectl" {
  host                   = try(local.k8sconfigs[0].host, null)
  username               = try(local.k8sconfigs[0].username, null)
  password               = try(local.k8sconfigs[0].password, null)
  client_certificate     = try(local.k8sconfigs[0].client_certificate, null)
  client_key             = try(local.k8sconfigs[0].client_key, null)
  cluster_ca_certificate = try(local.k8sconfigs[0].cluster_ca_certificate, null)
  alias                  = "kubectl1"
}

provider "flux" {
  alias = "flux1"
}

provider "kubernetes" {
  host                   = try(local.k8sconfigs[1].host, null)
  username               = try(local.k8sconfigs[1].username, null)
  password               = try(local.k8sconfigs[1].password, null)
  client_certificate     = try(local.k8sconfigs[1].client_certificate, null)
  client_key             = try(local.k8sconfigs[1].client_key, null)
  cluster_ca_certificate = try(local.k8sconfigs[1].cluster_ca_certificate, null)
  alias                  = "k8s2"
}

provider "helm" {
  kubernetes {
    host                   = try(local.k8sconfigs[1].host, null)
    username               = try(local.k8sconfigs[1].username, null)
    password               = try(local.k8sconfigs[1].password, null)
    client_certificate     = try(local.k8sconfigs[1].client_certificate, null)
    client_key             = try(local.k8sconfigs[1].client_key, null)
    cluster_ca_certificate = try(local.k8sconfigs[1].cluster_ca_certificate, null)
  }
  alias = "helm2"
}

provider "kubectl" {
  host                   = try(local.k8sconfigs[1].host, null)
  username               = try(local.k8sconfigs[1].username, null)
  password               = try(local.k8sconfigs[1].password, null)
  client_certificate     = try(local.k8sconfigs[1].client_certificate, null)
  client_key             = try(local.k8sconfigs[1].client_key, null)
  cluster_ca_certificate = try(local.k8sconfigs[1].cluster_ca_certificate, null)
  alias                  = "kubectl2"
}

provider "flux" {
  alias = "flux2"
}