resource "cloudflare_dns_record" "cs2" {
  zone_id = var.cloudflare_zone_id
  name    = var.hostname
  type    = "A"
  content = var.vps_ipv4_address
  proxied = false
  ttl     = var.ttl
  comment = "Terraform-managed DNS-only CS2 endpoint for the Frankfurt VPS."
}
