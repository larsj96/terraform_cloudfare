# Docs Cloudflare Tunnel

Terraform stack for exposing the internal MkDocs service through Cloudflare Tunnel.

## What It Manages

- Cloudflare Tunnel: `homelab-docs`
- Remote tunnel ingress:
  - `docs.lanilsen.com` -> `http://10.0.0.37`
  - fallback -> `http_status:404`
- Proxied DNS CNAME:
  - `docs.lanilsen.com` -> `<tunnel-id>.cfargotunnel.com`
- Sensitive tunnel token output for the `cloudflared` service on `mkdocs`.

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
