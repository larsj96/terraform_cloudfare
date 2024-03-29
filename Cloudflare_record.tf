# Add a record to the domain

variable "hostnames" {
  type = set(string)
  default = [
    "@",
    "vpn",
    "plex",
    "ombi",
    "metrics",
  ]
}



resource "cloudflare_record" "fortigate_wan_a_records" {

  for_each = var.hostnames
  zone_id = "37b50951304d33118935e0fcfe56f04c"
  name    = each.value
  value   = local.fortigate
  type    = "A"
  ttl     = 120
  allow_overwrite = true #default to false
  comment = "Created by terraform"
}

locals {
  octets = "${split(".", local.fortigate)}"
}

 resource "cloudflare_record" "fortigate_wan_ptr_records" {
   for_each = var.hostnames
   zone_id = "37b50951304d33118935e0fcfe56f04c"
   name    = each.value
   value   = "${local.octets[2]}.${local.octets[1]}.${local.octets[0]}.in-addr.arpa."
   type    = "PTR"
   ttl     = 120
   allow_overwrite = true #default to false
  comment = "Created by terraform"

 }