resource "cloudflare_zero_trust_access_application" "docs" {
  account_id           = var.cloudflare_account_id
  name                 = "Homelab Docs"
  domain               = var.docs_hostname
  type                 = "self_hosted"
  session_duration     = "24h"
  app_launcher_visible = false

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
