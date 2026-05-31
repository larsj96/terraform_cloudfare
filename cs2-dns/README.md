# CS2 DNS

Terraform stack for the public Counter-Strike 2 endpoint.

## What It Manages

DNS-only records:

```text
cs2.lanilsen.com -> 72.61.95.150
```

This must stay `proxied = false`. Cloudflare proxy and Tunnel only handle HTTP(S)-style traffic, while CS2 clients connect directly to the VPS on UDP/TCP `27016`.

Players should connect with:

```text
connect cs2.lanilsen.com:27016
```

## Backend

Use the shared R2 state bucket:

```bash
cp backend.r2.tfbackend.example backend.r2.tfbackend
terraform init -backend-config=backend.r2.tfbackend
```

## Apply

```bash
export CLOUDFLARE_API_TOKEN="..."
export AWS_ACCESS_KEY_ID="..."
export AWS_SECRET_ACCESS_KEY="..."

terraform plan
terraform apply
```
