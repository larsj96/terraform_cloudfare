# Add a record to the domain

variable "hostnames" {
  type = set(string)
  default = [
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
  value   = local.fortigate.wan_ip
  type    = "A"
  ttl     = 120
}

# resource "cloudflare_record" "fortigate_wan_ptr_records" {

#     for_each = var.hostnames
#   zone_id = "37b50951304d33118935e0fcfe56f04c"
#   name    = each.value
#   value   = local.fortigate.wan_ip
#   type    = "PTR"
#   ttl     = 120
# }