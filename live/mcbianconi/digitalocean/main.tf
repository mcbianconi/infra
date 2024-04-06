terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

variable "do_token" {
    sensitive = true
    type = string
    description = "value of the DigitalOcean API token"
}

provider "digitalocean" {
  token = var.do_token
}

resource "digitalocean_project" "default" {
  name        = "Default"
  description = "Default project"
  purpose     = "Web Application"
  environment = "Production"
  is_default = true

  resources = []
}