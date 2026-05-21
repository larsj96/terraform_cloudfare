resource "cloudflare_zero_trust_access_application" "docs" {
  account_id           = var.cloudflare_account_id
  name                 = "Homelab Docs"
  domain               = var.docs_hostname
  type                 = "self_hosted"
  session_duration     = "24h"
  app_launcher_visible = false
  allowed_idps         = [cloudflare_zero_trust_access_identity_provider.onetimepin.id]

  policies = [{
    name             = "Allow Lars docs access"
    decision         = "allow"
    session_duration = "24h"
    precedence       = 1

    include = [
      {
        email = {
          email = "larsj96@gmail.com"
        }
      },
      {
        email = {
          email = "jaguni@gmail.com"
        }
      },
    ]
  }]
}

resource "cloudflare_zero_trust_access_application" "grafana" {
  account_id           = var.cloudflare_account_id
  name                 = "Homelab Grafana"
  domain               = var.grafana_hostname
  type                 = "self_hosted"
  session_duration     = "24h"
  app_launcher_visible = false
  allowed_idps         = [cloudflare_zero_trust_access_identity_provider.onetimepin.id]

  policies = [{
    name             = "Allow Lars Grafana access"
    decision         = "allow"
    session_duration = "24h"
    precedence       = 1

    include = [
      {
        email = {
          email = "larsj96@gmail.com"
        }
      },
    ]
  }]
}
