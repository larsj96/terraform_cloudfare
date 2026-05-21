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
  default     = "http://10.0.0.37"
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

variable "tunnel_name" {
  description = "Cloudflare Tunnel name."
  type        = string
  default     = "homelab-docs"
}
