terraform {
  cloud {
    organization = "aura"

    workspaces {
      name = "authorized-keys"
    }
  }

}

locals {
  keyfile_params = {
    keys = [
      {
        name = "aurelia"
        type = "ssh-ed25519"
        data = "AAAAC3NzaC1lZDI1NTE5AAAAIIh2UTSCg9eV7rHYampoohtqGcjetZxbaWWPde67NzGS"
        desc = "Generic Key"
      }
    ]
  }
}

resource "github_user_ssh_key" "authorized_keys" {
  for_each = { for key in local.keyfile_params.keys : key.name => key }

  title = "${each.value.name} (${each.value.desc}, terraform managed key)"
  key   = "${each.value.type} ${each.value.data}"
}

# resource "hcloud_ssh_key" "authorized_keys" {
#   for_each = { for key in local.keyfile_params.keys : key.name => key }
#   name     = "${each.value.name} (${each.value.desc}, terraform managed key)"

#   public_key = "${each.value.type} ${each.value.data}"
# }

# resource "google_storage_bucket_object" "akf_data" {
#   name    = "authorized_keys"
#   content = templatefile("./akf.tmpl", local.keyfile_params)
#   bucket  = "tfstate-authorized-keys"
# }

# resource "google_storage_object_acl" "akf_data-acl" {
#   bucket = "tfstate-authorized-keys"
#   object = google_storage_bucket_object.akf_data.output_name

#   predefined_acl = "publicRead"
# }

# resource "google_storage_bucket_object" "akf_installscript" {
#   name    = "install-akf.bash"
#   content = templatefile("install-akf.bash.tmpl", { source_url = google_storage_bucket_object.akf_data.media_link })
#   bucket  = "tfstate-authorized-keys"
# }

# resource "google_storage_object_acl" "akf_installscript-acl" {
#   bucket = "tfstate-authorized-keys"
#   object = google_storage_bucket_object.akf_installscript.output_name

#   predefined_acl = "publicRead"
# }

# output "akf_install_link" {
#   value = google_storage_bucket_object.akf_installscript.media_link
# }

# output "akf_link" {
#   value = google_storage_bucket_object.akf_data.media_link
# }
