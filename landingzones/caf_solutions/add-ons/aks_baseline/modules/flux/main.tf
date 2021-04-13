terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
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

provider "kubernetes" {
}

provider "kubectl" {
}

provider "flux" {
}