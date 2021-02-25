terraform {
  required_providers {
    github = {
      source = "integrations/github"
    }
    hcloud = {
      source = "hetznercloud/hcloud"
    }
  }
  required_version = ">= 0.13"
}
