output "cs2_dns_record" {
  description = "CS2 DNS record."
  value = {
    hostname      = cloudflare_dns_record.cs2.name
    type          = cloudflare_dns_record.cs2.type
    content       = cloudflare_dns_record.cs2.content
    proxied       = cloudflare_dns_record.cs2.proxied
    ttl           = cloudflare_dns_record.cs2.ttl
    cloudflare_id = cloudflare_dns_record.cs2.id
  }
}
