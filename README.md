# Personal infra

This project uses Terraform to manage my personal infrastructure on cloud providers.

## Prerequisites

- Terraform
- DigitalOcean API token
- Cloudflare API token

## Usage

1. Navigate to the `live/mcbianconi/<cloud_provider>` directory.
2. Run `terraform init` to initialize the Terraform working directory.
3. Run `terraform apply` to create the infrastructure.

## Cloudflare

### Variables
- `cloudflare_token`: Cloudflare API token

### Token Permissions
- Account
    - Cloudflare Pages: Edit
    - Account Settings: Edit
- All zones
    - Zone Settings: Edit
    - Zone: Edit
    - Page Rules: Edit
    - DNS: Edit
- All users 
    - Memberships: Edit
    - User Details: Edit


## Digital Ocean
### Variables
- `do_token`: Digital Ocean Token