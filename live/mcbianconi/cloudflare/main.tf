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