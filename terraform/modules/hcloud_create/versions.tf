terraform {
  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "1.20.1"
    }
    null = {
      source  = "hashicorp/null"
      version = "2.1.2"
    }
    local = {
      source  = "hashicorp/local"
      version = "1.4.0"
    }
  }
  required_version = ">= 0.13"
}
