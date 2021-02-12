terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "1.13.2"
    }
  }

  required_version = ">= 0.13"
}
