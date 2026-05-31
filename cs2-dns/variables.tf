variable "cloudflare_zone_id" {
  description = "Cloudflare zone ID for lanilsen.com."
  type        = string
  default     = "e3aca4623d7fcdc887ecfe460106e11e"
}

variable "hostname" {
  description = "CS2 public hostname."
  type        = string
  default     = "game.cs2.lanilsen.com"
}

variable "vps_ipv4_address" {
  description = "Frankfurt VPS public IPv4 address."
  type        = string
  default     = "72.61.95.150"
}

variable "ttl" {
  description = "DNS TTL in seconds."
  type        = number
  default     = 120
}
