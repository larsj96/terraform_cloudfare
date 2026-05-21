resource "random_id" "tunnel_secret" {
  byte_length = 32
}

resource "cloudflare_zero_trust_tunnel_cloudflared" "docs" {
  account_id    = var.cloudflare_account_id
  name          = var.tunnel_name
  config_src    = "cloudflare"
  tunnel_secret = random_id.tunnel_secret.b64_std
}

resource "cloudflare_zero_trust_tunnel_cloudflared_config" "docs" {
  account_id = var.cloudflare_account_id
  tunnel_id  = cloudflare_zero_trust_tunnel_cloudflared.docs.id

  config = {
    ingress = [
      {
        hostname = var.docs_hostname
        service  = var.docs_origin_url
      },
      {
        hostname = var.grafana_hostname
        service  = var.grafana_origin_url
      },
      {
        service = "http_status:404"
      },
    ]
  }
}

resource "cloudflare_dns_record" "docs" {
  zone_id = var.cloudflare_zone_id
  name    = var.docs_hostname
  type    = "CNAME"
  content = "${cloudflare_zero_trust_tunnel_cloudflared.docs.id}.cfargotunnel.com"
  proxied = true
  ttl     = 1
  comment = "Terraform-managed Cloudflare Tunnel record for homelab MkDocs."
}

resource "cloudflare_dns_record" "grafana" {
  zone_id = var.cloudflare_zone_id
  name    = var.grafana_hostname
  type    = "CNAME"
  content = "${cloudflare_zero_trust_tunnel_cloudflared.docs.id}.cfargotunnel.com"
  proxied = true
  ttl     = 1
  comment = "Terraform-managed Cloudflare Tunnel record for homelab Grafana."
}

data "cloudflare_zero_trust_tunnel_cloudflared_token" "docs" {
  account_id = var.cloudflare_account_id
  tunnel_id  = cloudflare_zero_trust_tunnel_cloudflared.docs.id
}
