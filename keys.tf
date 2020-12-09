provider "digitalocean" {}
provider "github" {}
provider "hcloud" {}

locals {
  keyfile_params = {
    keys = [
      {
        name = "work",
        type = "ssh-rsa"
        data = "AAAAB3NzaC1yc2EAAAADAQABAAACAQDk5SAIudmHU9MmlCDImi0jP4HpZn9T7wgcXHNW65C4T9v+hLUgZfANRPr6PdqR7vH/F3JJMeKtGstAFmiq6HvXTFm/Eafz5gyN3nv7LVCGA+D7PYCEHHIgpODZZj1QUTkekS0RETyQJyFeBxp0SqlwK1yrzYEBISqHEGv3Vm0uQOwZKemYxjDiC6Xhq6EAn9wR4C7s9we44yaq8PEsp5mrZWR4k2tNMUQzc7eTrtAwWRvYzTHztcNkiaVvRIzyqfMwpyvqExG3sFWu+rqmiELIR6jUGIpkyy1y/16SUmiHaksYqJ7c/B3SVoKLFIHIfDS+pviU+7K/nJC5Y0RoRHVRHHSWY1LWRxZiQtsPP5qScTvgIA/J+PeHWscFZQr1izs87wAQM0xGpJX/Cv3hGjBkd9HIlb5rVYuK+jltiX2hXeqZd9CUKnTWg3aeJ8DRLkw9A0v70Egax2iTTSp8bxTATa4G/yL0MwfZYq91pJa+jCfpoL4BxY0ZR/4u1zm3hvomotfuO81+746OcmyPBZLRJ+GAt6SF2E5hoayV8xY7j/Zfke6rkWEo6tiCGQHK2CkZY8PXr8IoJ9hCBYumAicpbRO1eR+TKkMrocRbUTHx37SQ75L5007NrOVqlj3QOdGC9kg0SbRg6aFh2bufX5rUv4XCzRavD2J4N9hDkiqgvw=="
        desc = "Work enabled key, VM"
      },
      {
        name = "sunhome"
        type = "ssh-ed25519"
        data = "AAAAC3NzaC1lZDI1NTE5AAAAIBluWf8q/PNbi3g42E/2N2ZcFH9Yc5hX2E7yFqa1VEkj"
        desc = "MBP"
      },
      {
        name = "lesbos"
        type = "ssh-ed25519"
        data = "AAAAC3NzaC1lZDI1NTE5AAAAILPLhUqiimAqaX+6SCpZxEC2UosFH4eqQ/yo0Ep+VVXG"
        desc = "Desktop, in WSL"
      },
      {
        name = "iPhone-WorkingCopy",
        type = "ssh-rsa"
        data = "AAAAB3NzaC1yc2EAAAADAQABAAACAQDq/+3fGFDdCRDPC9aGX/kUSycstIRF0y65Dts+zas9cyMOE3+w4v8yhemXcHwXv1viusmWtz6O7a/2B01j4l0d3Nu03MLlR+8nOaX1Vz4fQGJo72yGhrnfzpNSk7T0QHtHX99qnS8PEFJD7wwpRuRtyvfJvhnZ8ox4iG4YUyaalMAJ4cEIocrQtQc/zPiWC0ULQx4SHuFRQClioKJ2hXncrRPm/iVZwRwL+735pOznTdYTZLrcW2HXdz6Cb7cypFNaxkmGT+q3c06Ja+Re2/lq90B8gQ8Bp2naY71oi1jS7LoyurF9yqHQZiQNlObEwcIu+ZaICBZyY6ZYdGPPR2lvKoxCF4S+pihhJTMCvsuBTBlNBd+JbEWSMNrrfJyoS4usBoRR5wTQ+wNhfhJSfU+YDWIgFIxo7irbuqECcUW34nuy9aAuQBa0qTdahS1F9nC9wSzfrkcBe7fGO77YwhRIdCyCAcdSii4SpEkvhQTG9veZxhqVM9t4oZgzjN4cYkkcfHsH91rAT0Gdgq3dwcEYxpLonDfntmBR4fUN35FEbIbfkQZeR1nEbR6eXqdEJT528rF/IfDy2rejuF0F9eHsJ0IJCCla31Ol9ERdW7Do6EMeK8L/Oq7d17IO3i+x+t0SztVgyzCvADn2OS4f8BNaWH/1qy+o1+lnTHcc/n32Yw=="
        desc = "Working Copy on Aurelia's iPhone"
      }
    ]
  }
}

resource "digitalocean_spaces_bucket_object" "authorized_keys" {
  region  = "ams3"
  bucket  = "aura-cfg"
  key     = "authorized_keys"
  content = templatefile("./akf.tmpl", local.keyfile_params)
  acl     = "public-read"
}

resource "digitalocean_spaces_bucket_object" "install-akf" {
  region  = "ams3"
  bucket  = "aura-cfg"
  key     = "install-akf.bash"
  content = file("install-akf.bash")
  acl     = "public-read"
}

resource "github_user_ssh_key" "authorized_keys" {
  for_each = { for key in local.keyfile_params.keys : key.name => key }

  title = "${each.value.name} (${each.value.desc})"
  key   = "${each.value.type} ${each.value.data}"
}

resource "hcloud_ssh_key" "authorized_keys" {
  for_each = { for key in local.keyfile_params.keys : key.name => key }
  name     = "${each.value.name} (${each.value.desc})"

  public_key = "${each.value.type} ${each.value.data}"
}

resource "digitalocean_ssh_key" "authorized_keys" {
  for_each = { for key in local.keyfile_params.keys : key.name => key }

  name       = "${each.value.name} (${each.value.desc})"
  public_key = "${each.value.type} ${each.value.data}"
}

resource "vultr_ssh_key" "authorized_keys" {
  for_each = { for key in local.keyfile_params.keys : key.name => key }
    
  name = "${each.value.name} (${each.value.desc})"
  ssh_key = "${each.value.type} ${each.value.data}"
}
