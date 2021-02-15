terraform {
  required_version = ">= 0.13"

  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "1.13.2"
    }
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "1.20.1"
    }
    null = {
      source  = "hashicorp/null"
      version = "2.1.2"
    }
    rke = {
      source  = "rancher/rke"
      version = "1.1.1"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "2.11.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "1.3.0"
    }
  }
}
