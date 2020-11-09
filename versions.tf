terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
    }
  }
  backend "s3" {
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    endpoint                    = "https://ams3.digitaloceanspaces.com"
    region                      = "us-east-1"
    bucket                      = "aura-cfg"
    key                         = "terraform/authorized_keys.tfstate"
    acl                         = "private"
  }
  required_version = ">= 0.13"
}
