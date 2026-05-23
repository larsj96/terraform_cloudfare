output "docs_hostname" {
  value = var.docs_hostname
}

output "grafana_hostname" {
  value = var.grafana_hostname
}

output "auth_hostname" {
  value = var.auth_hostname
}

output "mgmt_hostname" {
  value = var.mgmt_hostname
}

output "code_hostname" {
  value = var.code_hostname
}

output "docs_tunnel_id" {
  value = cloudflare_zero_trust_tunnel_cloudflared.docs.id
}

output "mgmt_tunnel_id" {
  value = cloudflare_zero_trust_tunnel_cloudflared.mgmt.id
}

output "docs_access_application_id" {
  value = cloudflare_zero_trust_access_application.docs.id
}

output "grafana_access_application_id" {
  value = cloudflare_zero_trust_access_application.grafana.id
}

output "mgmt_access_application_id" {
  value = cloudflare_zero_trust_access_application.mgmt.id
}

output "code_access_application_id" {
  value = cloudflare_zero_trust_access_application.code.id
}

output "docs_access_identity_provider_id" {
  value = cloudflare_zero_trust_access_identity_provider.onetimepin.id
}

output "cloudflared_tunnel_token" {
  value     = data.cloudflare_zero_trust_tunnel_cloudflared_token.docs.token
  sensitive = true
}

output "mgmt_cloudflared_tunnel_token" {
  value     = data.cloudflare_zero_trust_tunnel_cloudflared_token.mgmt.token
  sensitive = true
}
