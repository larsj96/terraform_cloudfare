terraform {
  required_providers {
    cloudflare = {
      source = "cloudflare/cloudflare"
      version = "3.26.0"
    }
  }

    backend "http" {
  }
}



# data "cloudflare_record" "test" {
#   zone_id  = "37b50951304d33118935e0fcfe56f04c"
#   hostname = "lanilsen.xyz"
# }