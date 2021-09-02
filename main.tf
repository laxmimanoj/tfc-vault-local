terraform {
  required_providers {
    vault = {
      source  = "hashicorp/vault"
      version = "2.23.0"
    }
  }

  #   backend "remote" {
  #     organization = "laxmimanoj"
  #     workspaces {
  #       name = "tfc-vault-local"
  #     }
  #   }
}

provider "vault" {
  # Configuration options
}

# locals {
#   policy_name = "policy-${var.application_name}"
#   role_name   = "role-${var.application_name}"
# }