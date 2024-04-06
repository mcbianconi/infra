terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.0"
    }
  }
}

variable "cloudflare_token" {
  sensitive = true
  type      = string
}


provider "cloudflare" {
  api_token = var.cloudflare_token
}

resource "cloudflare_account" "mcbianconi" {
  name              = "Murillo Bianconi"
  type              = "standard"
  enforce_twofactor = true
}

resource "cloudflare_zone" "mcbianconi" {
  account_id = cloudflare_account.mcbianconi.id
  zone       = "mcbianconi.com"
  plan       = "free"
  paused     = false
  type       = "full"
}

resource "cloudflare_pages_domain" "mcbianconi" {
  account_id   = cloudflare_account.mcbianconi.id
  project_name = cloudflare_pages_project.mcbianconi.name
  domain       = cloudflare_zone.mcbianconi.zone
}

resource "cloudflare_record" "mcbianconi" {
  zone_id = cloudflare_zone.mcbianconi.id
  name    = "mcbianconi.com"
  value   = "mcbianconi.pages.dev"
  type    = "CNAME"
  ttl     = 3600
}

resource "cloudflare_pages_project" "mcbianconi" {
  account_id        = cloudflare_account.mcbianconi.id
  name              = "mcbianconi"
  production_branch = "main"

  source {
    type = "github"
    config {
      owner                         = "mcbianconi"
      repo_name                     = "mcbianconi.com"
      production_branch             = "main"
      pr_comments_enabled           = true
      deployments_enabled           = true
      production_deployment_enabled = true
      preview_deployment_setting    = "custom"
      preview_branch_includes       = ["dev", "preview"]
      preview_branch_excludes       = ["main", "prod"]
    }
  }

  build_config {
    build_command   = "hugo -d public"
    destination_dir = "public"
  }

  deployment_configs {
    production {
      environment_variables = {
        HUGO_VERSION = "0.124.1"
      }
    }
  }
}

 