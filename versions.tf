terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
    }
    github = {
      source = "hashicorp/github"
    }
    hcloud = {
      source = "hetznercloud/hcloud"
    }
  }
  backend "gcs" {
    bucket                      = "aura-cfg"
  }
  required_version = ">= 0.13"
}
