terraform {
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "1.3.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "1.13.2"
    }
  }

  required_version = ">= 0.13"
}
