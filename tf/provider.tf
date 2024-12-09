terraform {
  required_version = ">= v1.6.0"

  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "~> 2.31.0"
    }
  }
}

provider "kubernetes" {
  config_path    = "~/.kube/config-${local.env}"
  config_context = "default"
}
