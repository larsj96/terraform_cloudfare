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

 # Azure DNS for azure.lanilsen.xyz
 resource "cloudflare_record" "azure_lanilsen_xyz_ns" {
  for_each = toset([
    "ns1-37.azure-dns.com.",
    "ns2-37.azure-dns.net.",
    "ns3-37.azure-dns.org.",
    "ns4-37.azure-dns.info.",
  ])

  zone_id = "37b50951304d33118935e0fcfe56f04c"
  name    = "azure"
  type    = "NS"
  value   = each.value
  ttl     = 1 # Automatisk TTL
}