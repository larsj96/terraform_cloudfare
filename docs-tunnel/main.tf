resource "random_id" "tunnel_secret" {
  byte_length = 32
}

resource "random_id" "mgmt_tunnel_secret" {
  byte_length = 32
}

resource "cloudflare_zero_trust_tunnel_cloudflared" "docs" {
  account_id    = var.cloudflare_account_id
  name          = var.tunnel_name
  config_src    = "cloudflare"
  tunnel_secret = random_id.tunnel_secret.b64_std
}

resource "cloudflare_zero_trust_tunnel_cloudflared" "mgmt" {
  account_id    = var.cloudflare_account_id
  name          = var.mgmt_tunnel_name
  config_src    = "cloudflare"
  tunnel_secret = random_id.mgmt_tunnel_secret.b64_std
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
        hostname = var.auth_hostname
        service  = var.auth_origin_url
      },
      {
        service = "http_status:404"
      },
    ]
  }
}

resource "cloudflare_zero_trust_tunnel_cloudflared_config" "mgmt" {
  account_id = var.cloudflare_account_id
  tunnel_id  = cloudflare_zero_trust_tunnel_cloudflared.mgmt.id

  config = {
    ingress = [
      {
        hostname = var.mgmt_hostname
        service  = "http://localhost:3000"
      },
      {
        hostname = var.code_hostname
        service  = "http://localhost:8081"
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

resource "cloudflare_dns_record" "auth" {
  zone_id = var.cloudflare_zone_id
  name    = var.auth_hostname
  type    = "CNAME"
  content = "${cloudflare_zero_trust_tunnel_cloudflared.docs.id}.cfargotunnel.com"
  proxied = true
  ttl     = 1
  comment = "Terraform-managed Cloudflare Tunnel record for Authentik SSO."
}

resource "cloudflare_dns_record" "mgmt" {
  zone_id = var.cloudflare_zone_id
  name    = var.mgmt_hostname
  type    = "CNAME"
  content = "${cloudflare_zero_trust_tunnel_cloudflared.mgmt.id}.cfargotunnel.com"
  proxied = true
  ttl     = 1
  comment = "Terraform-managed Cloudflare Tunnel record for homelab management workbench."
}

resource "cloudflare_dns_record" "code" {
  zone_id = var.cloudflare_zone_id
  name    = var.code_hostname
  type    = "CNAME"
  content = "${cloudflare_zero_trust_tunnel_cloudflared.mgmt.id}.cfargotunnel.com"
  proxied = true
  ttl     = 1
  comment = "Terraform-managed Cloudflare Tunnel record for homelab code-server."
}

data "cloudflare_zero_trust_tunnel_cloudflared_token" "docs" {
  account_id = var.cloudflare_account_id
  tunnel_id  = cloudflare_zero_trust_tunnel_cloudflared.docs.id
}

data "cloudflare_zero_trust_tunnel_cloudflared_token" "mgmt" {
  account_id = var.cloudflare_account_id
  tunnel_id  = cloudflare_zero_trust_tunnel_cloudflared.mgmt.id
}
