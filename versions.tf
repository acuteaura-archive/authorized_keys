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
    vultr = {
      source = "vultr/vultr"
    }
  }
  required_version = ">= 0.13"
}
