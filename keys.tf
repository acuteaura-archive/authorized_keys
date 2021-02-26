terraform {
  backend "gcs" {
    bucket = "tfstate-authorized-keys"
  }
}

locals {
  keyfile_params = {
    keys = [
      {
        name = "tali"
        type = "ssh-rsa"
        data = "AAAAB3NzaC1yc2EAAAADAQABAAACAQCyAvJXX/H8ZIQl5MijHw/re6vv9eDx66FrmqVDryZXU60eA1xfaZpkcfDlTDd5M4ivM1nLa6kLcpG3p3Oug5ZpIdtp2hQpgsVBp0iZHepx535/wylgDyxgOym6oRgUGwagTMgUFotlyXD9aH6qagD7MaZVQUu6QiDPl3KiFZZBLUeb6wA62R/Oml/Xiw6NgBnIm+lA7TOyHs5v8+q+rzynEmGH8QdUyLbizW1DbbL3//pYALCtoHeCI/fWbcMS3PCBmfxHcdPKcphvX1bZqXmC2hSU1wvpe968cDo7LRKWXkjZYUWcZgvw9nWgfFhtsIJ9ppzum+yW/zjsZmks6mt8U+f+s2fGtdnlbjx2ICRoUsW76+X8KIoQBMwng2zrFBO+NQ/M7E3/C7z1rHmsRXc8Wzj5xiG/ywlMHILNBZQJa+GSOqG4baHf10SmIBnJ6T9UH9o4mdku/Xpuc5V4kMaMNxNvVAREBvMFSpcY7MByhtwT5WaridAje/6nv3ovhjTa/Poa3BtZZI+hwNDGZ9I6u3YdjmbvVw7xZGSUJkbzpKWttCe6Yg7NtQ6VFlh3eOQFbfhed/K7xbq1nauAb5PI3PR616Z2N/CZ6BKdkPUr/vOKdaNU7Q1Chz/822YmgaJjXoBsdbXaYkOhcwbnTT8kY0hKVt5Ly/lBd5k0HiVTSw=="
        desc = "T495"
      },
      {
        name = "lesbos"
        type = "ssh-ed25519"
        data = "AAAAC3NzaC1lZDI1NTE5AAAAILPLhUqiimAqaX+6SCpZxEC2UosFH4eqQ/yo0Ep+VVXG"
        desc = "WSL Desktop"
      }
    ]
  }
}

resource "github_user_ssh_key" "authorized_keys" {
  for_each = { for key in local.keyfile_params.keys : key.name => key }

  title = "${each.value.name} (${each.value.desc}, terraform managed key)"
  key   = "${each.value.type} ${each.value.data}"
}

resource "hcloud_ssh_key" "authorized_keys" {
  for_each = { for key in local.keyfile_params.keys : key.name => key }
  name     = "${each.value.name} (${each.value.desc}, terraform managed key)"

  public_key = "${each.value.type} ${each.value.data}"
}

resource "google_storage_bucket_object" "akf_data" {
  name    = "authorized_keys"
  content = templatefile("./akf.tmpl", local.keyfile_params)
  bucket  = "tfstate-authorized-keys"
}

resource "google_storage_object_acl" "akf_data-acl" {
  bucket = "tfstate-authorized-keys"
  object = google_storage_bucket_object.akf_data.output_name

  predefined_acl = "publicRead"
}

resource "google_storage_bucket_object" "akf_installscript" {
  name    = "install-akf.bash"
  content = templatefile("install-akf.bash.tmpl", { source_url = google_storage_bucket_object.akf_data.media_link })
  bucket  = "tfstate-authorized-keys"
}

resource "google_storage_object_acl" "akf_installscript-acl" {
  bucket = "tfstate-authorized-keys"
  object = google_storage_bucket_object.akf_installscript.output_name

  predefined_acl = "publicRead"
}

output "akf_install_link" {
  value = google_storage_bucket_object.akf_installscript.media_link
}

output "akf_link" {
  value = google_storage_bucket_object.akf_data.media_link
}
