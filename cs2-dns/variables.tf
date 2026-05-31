variable "cloudflare_zone_id" {
  description = "Cloudflare zone ID for lanilsen.xyz."
  type        = string
  default     = "37b50951304d33118935e0fcfe56f04c"
}

variable "hostname" {
  description = "CS2 public hostname."
  type        = string
  default     = "cs2.lanilsen.xyz"
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
