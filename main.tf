terraform {
  required_providers {
    cloudflare = {
      source = "cloudflare/cloudflare"
      version = "4.25.0"
    }
  }

  cloud {
    organization = "lanilsen"

    workspaces {
      name = "Cloudfare"
    }
  }

}


provider "cloudflare" {
  # CLOUDFLARE_API_TOKEN ENV VARIABLE
}
