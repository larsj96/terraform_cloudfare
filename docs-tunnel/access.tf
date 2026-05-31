locals {
  default_authenticated_emails = [
    "larsj96@gmail.com",
    "mikael.fjell@hotmail.com",
  ]

  docs_authenticated_emails = [
    "larsj96@gmail.com",
    "jaguni@gmail.com",
  ]
}

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
      for email_address in local.docs_authenticated_emails : {
        email = {
          email = email_address
        }
      }
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
      for email_address in local.default_authenticated_emails : {
        email = {
          email = email_address
        }
      }
    ]

  }]
}

resource "cloudflare_zero_trust_access_application" "mgmt" {
  account_id           = var.cloudflare_account_id
  name                 = "Homelab Management Workbench"
  domain               = var.mgmt_hostname
  type                 = "self_hosted"
  session_duration     = "12h"
  app_launcher_visible = false
  allowed_idps         = [cloudflare_zero_trust_access_identity_provider.onetimepin.id]

  policies = [{
    name             = "Allow Lars management access"
    decision         = "allow"
    session_duration = "12h"
    precedence       = 1

    include = [
      {
        email = {
          email = "larsj96@gmail.com"
        }
      },
    ]

    require = [
      for cidr in var.management_access_allowed_source_cidrs : {
        ip = {
          ip = cidr
        }
      }
    ]
  }]
}

resource "cloudflare_zero_trust_access_application" "code" {
  account_id           = var.cloudflare_account_id
  name                 = "Homelab Code Workbench"
  domain               = var.code_hostname
  type                 = "self_hosted"
  session_duration     = "12h"
  app_launcher_visible = false
  allowed_idps         = [cloudflare_zero_trust_access_identity_provider.onetimepin.id]

  policies = [{
    name             = "Allow Lars code access"
    decision         = "allow"
    session_duration = "12h"
    precedence       = 1

    include = [
      {
        email = {
          email = "larsj96@gmail.com"
        }
      },
    ]

    require = [
      for cidr in var.management_access_allowed_source_cidrs : {
        ip = {
          ip = cidr
        }
      }
    ]
  }]
}

resource "cloudflare_zero_trust_access_application" "public_tunnel_apps" {
  for_each = {
    for name, app in var.public_tunnel_apps : name => app
    if try(app.access_enabled, true)
  }

  account_id           = var.cloudflare_account_id
  name                 = "Homelab ${each.key}"
  domain               = each.value.hostname
  type                 = "self_hosted"
  session_duration     = try(each.value.session_duration, "24h")
  app_launcher_visible = false
  allowed_idps         = [cloudflare_zero_trust_access_identity_provider.onetimepin.id]

  policies = [{
    name             = "Allow ${each.key} access"
    decision         = "allow"
    session_duration = try(each.value.session_duration, "24h")
    precedence       = 1

    include = [
      for email_address in try(each.value.allowed_emails, local.default_authenticated_emails) : {
        email = {
          email = email_address
        }
      }
    ]
  }]
}
