# Homelab Cloudflare Tunnels

Terraform stack for exposing selected internal homelab services through Cloudflare Tunnel and Cloudflare Access.

## What It Manages

- Cloudflare Tunnel: `homelab-docs`
- Remote tunnel ingress:
  - `docs.lanilsen.com` -> `http://10.0.0.35`
  - `grafana.lanilsen.com` -> `http://10.0.0.38:3000`
  - `auth.lanilsen.com` -> `http://10.0.0.36:9000`
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
