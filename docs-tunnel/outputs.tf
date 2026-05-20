output "docs_hostname" {
  value = var.docs_hostname
}

output "docs_tunnel_id" {
  value = cloudflare_zero_trust_tunnel_cloudflared.docs.id
}

output "docs_access_application_id" {
  value = cloudflare_zero_trust_access_application.docs.id
}

output "cloudflared_tunnel_token" {
  value     = data.cloudflare_zero_trust_tunnel_cloudflared_token.docs.token
  sensitive = true
}
