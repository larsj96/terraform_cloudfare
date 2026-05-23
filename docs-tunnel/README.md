# Homelab Cloudflare Tunnels

Terraform stack for exposing selected internal homelab services through Cloudflare Tunnel and Cloudflare Access.

## What It Manages

- Cloudflare Tunnel: `homelab-docs`
- Remote tunnel ingress:
  - `docs.lanilsen.com` -> `http://10.0.0.35`
  - `grafana.lanilsen.com` -> `http://10.0.0.38:3000`
  - `auth.lanilsen.com` -> `http://10.0.0.36:9000`
  - additional entries from `public_tunnel_apps`
  - fallback -> `http_status:404`
- Cloudflare Tunnel: `homelab-mgmt`
- Remote tunnel ingress:
  - `mgmt.lanilsen.com` -> `http://localhost:3000` on `mgmt1`
  - `code.lanilsen.com` -> `http://localhost:8081` on `mgmt1`
  - fallback -> `http_status:404`
- Proxied DNS CNAME:
  - `docs.lanilsen.com` -> `<tunnel-id>.cfargotunnel.com`
  - `grafana.lanilsen.com` -> `<docs-tunnel-id>.cfargotunnel.com`
  - `auth.lanilsen.com` -> `<docs-tunnel-id>.cfargotunnel.com`
  - each `public_tunnel_apps[*].hostname` -> `<docs-tunnel-id>.cfargotunnel.com`
  - `mgmt.lanilsen.com` -> `<mgmt-tunnel-id>.cfargotunnel.com`
  - `code.lanilsen.com` -> `<mgmt-tunnel-id>.cfargotunnel.com`
- Cloudflare Access applications using one-time PIN identity provider.
- Sensitive tunnel token outputs for `cloudflared` services.

## Backend

Use the shared R2 state bucket with an isolated key:

```bash
cp backend.r2.tfbackend.example backend.r2.tfbackend
terraform init -backend-config=backend.r2.tfbackend
```

## Apply

```bash
export CLOUDFLARE_API_TOKEN="..."
export AWS_ACCESS_KEY_ID="..."
export AWS_SECRET_ACCESS_KEY="..."

terraform apply
```

After apply, install the tunnel connector on `mkdocs` with Ansible using the sensitive output:

```bash
terraform output -raw cloudflared_tunnel_token
```

Install the management connector on `mgmt1` with:

```bash
terraform output -raw mgmt_cloudflared_tunnel_token
```

## Additional Public Apps

Use `public_tunnel_apps` for extra hostnames under `lanilsen.com` that should enter through the same homelab tunnel.

Default:

```hcl
public_tunnel_apps = {
  plex1 = {
    hostname       = "plex1.lanilsen.com"
    origin_url     = "http://plex1.mgmt.nilsen-tech.com:32400"
    access_enabled = false
  }
}
```

`plex1.mgmt.nilsen-tech.com` is an internal Fortigate DNS name. The cloudflared host must use the Fortigate resolver or another resolver that can forward `mgmt.nilsen-tech.com` to the Fortigate side.

Keep Cloudflare Access enabled for admin web apps such as Ombi, Grafana, and internal dashboards. Leave it disabled for Plex unless you have verified the Plex clients you use can handle Cloudflare Access. Heavy Plex streaming should prefer GlobalProtect/VPN or a direct remote access design rather than Cloudflare Tunnel.

The current Plex origin points directly at Plex on port `32400` so the hostname works before the internal reverse proxy exists. Once the reverse proxy has a trusted certificate and host routing, change the origin to:

```hcl
origin_url = "https://plex1.mgmt.nilsen-tech.com"
```
