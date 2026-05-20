terraform {
  required_version = ">= 1.10.0"

  backend "s3" {}

  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 5.19"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.7"
    }
  }
}
