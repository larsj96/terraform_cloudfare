variable "cloudflare_account_id" {
  description = "Cloudflare account ID."
  type        = string
  default     = "10fe772bf2d6ab4c5ec76c0aceba8ae6"
}

variable "cloudflare_zone_id" {
  description = "Cloudflare zone ID for lanilsen.com."
  type        = string
  default     = "e3aca4623d7fcdc887ecfe460106e11e"
}

variable "docs_hostname" {
  description = "Public docs hostname."
  type        = string
  default     = "docs.lanilsen.com"
}

variable "docs_origin_url" {
  description = "Internal origin URL reached from cloudflared."
  type        = string
  default     = "http://10.0.0.35"
}

variable "grafana_hostname" {
  description = "Public Grafana hostname."
  type        = string
  default     = "grafana.lanilsen.com"
}

variable "grafana_origin_url" {
  description = "Internal Grafana origin URL reached from cloudflared."
  type        = string
  default     = "http://10.0.0.38:3000"
}

variable "auth_hostname" {
  description = "Public Authentik hostname."
  type        = string
  default     = "auth.lanilsen.com"
}

variable "auth_origin_url" {
  description = "Internal Authentik origin URL reached from cloudflared."
  type        = string
  default     = "http://10.0.0.36:9000"
}

variable "mgmt_hostname" {
  description = "Public management workbench hostname."
  type        = string
  default     = "mgmt.lanilsen.com"
}

variable "mgmt_origin_url" {
  description = "Internal browser desktop origin URL reached from cloudflared."
  type        = string
  default     = "http://10.0.0.100:3000"
}

variable "code_hostname" {
  description = "Public code-server hostname for the management workbench."
  type        = string
  default     = "code.lanilsen.com"
}

variable "code_origin_url" {
  description = "Internal code-server origin URL reached from cloudflared."
  type        = string
  default     = "http://10.0.0.100:8081"
}

variable "tunnel_name" {
  description = "Cloudflare Tunnel name."
  type        = string
  default     = "homelab-docs"
}

variable "mgmt_tunnel_name" {
  description = "Cloudflare Tunnel name for the management workbench connector."
  type        = string
  default     = "homelab-mgmt"
}

variable "management_access_allowed_source_cidrs" {
  description = "Public source CIDRs allowed to reach the management workbench Access apps."
  type        = list(string)
  default     = ["213.52.58.244/32"]
}
