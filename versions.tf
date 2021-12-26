terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 4.19.0"
    }
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "~> 1.32.2"
    }
  }
  required_version = ">= 1.0"
}
