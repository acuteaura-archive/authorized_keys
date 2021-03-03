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
      },
      {
        name = "wsl-work",
        type = "ssh-rsa"
        data = "AAAAB3NzaC1yc2EAAAADAQABAAACAQC6e0oYWts4eegKnz1470HSVEEwceAXki0Eh693vqFw3C6eGjyK7k0V4XQ/SLmpHTAt6sHpHtmXU+PfDEnct5XfpehSTJwomhRIcmn01T6I0dw1KOBFhP9i+pRoyI9mVdG1Otl0yPrfhUEiABNAvEK9WTnt1CN/hH0O5jPv5qderZtujfbybWc7dJRUeEoendIBuEoSnEaTpbHhBzObohF5eW7kmJYyVDuyN0N++L98pV3pWWZS6F5RIulT8nfHp8JqsWdCu7HpoiDI6obHUO3u8acZmLA9W0/phEnmWDrTndF8JwMqHJFdxRre2qm52hQHma+RwgpLhDaWGRvcR8xaLGl8J5EpNXCZdE+dNTRPb2muXOfN9M3sjHORLn9ywRKeJmD11wn/o1X8is+c/xOZKh9QTK+2bDM8BD4eMBRpJL3CdIWGuAN/I14mEjObfgzH8tfQUt/XCmQfv28RU5qqbMWeoERRlzOiy1jjSIY8MbWgBceGcWgiP92IEPTA5RvI/ySepjn7yFh58QzPwIffHqPHeSZfo8eS+YZa1KQWQ1d8NdGoHqPjMvIEK2jkMaSErrCBzERPkyksLfECG/gFDNnNMLt1hcw1qVA7JF7i4syhLsjFQQOLT8vpzQoa3hSek94CwKNpyMYm2LRiiGE7sblZPQ/dVuiaI5teRwQDxw=="
        desc = "WSL work"
      },
      {
        name = "work",
        type = "ssh-rsa"
        data = "AAAAB3NzaC1yc2EAAAADAQABAAACAQC88Zuaib1xuYJFl7KwT2qBmviWhFAnD4wtG9r9vDvvPicqpE7qQc43LVtsTpI/HoDTAUOwLh5lHNjCLF5t9sye98IyWlaTq7C4uo8kp8Zeg6L8mInfAU7IFbvr/QegaMmDVamlGhjvtxXkQRNU/F1GAgmvxLX1RPAoZnBRBg4x8rNlsf64Kh5w0ATsdvwTmskn4t7l6s/NxUFOa+ETxp75eS6GLNOnpsZrRgRjZalgDUg0S9FIedjjrmVoTATaX49DroyneZGzxmqqUX+Ud/zm69HU8iewn/6gCKJ4W6H3qNG547y10mx2THwVSItW5DS8Deay0XMi5gzcQQBis3DHWirFQN7EtIva7/ignFbQoEqcwLDnuPuHbTBDXSBhYXAHgretpQ24QCwSNq06OTKEpxyPjJmKqijyVC6o/1NolMzL/PHYNNZnHc/YkTmu9fWGYg7XmbYH16hCpZm36PZXfA7Q46ZtyP80NaK/Jhi8DqETJ7kCb/XUtN1rSkC0qbu8AhmcpPcrhmpdlzddQdaRwI4lL9Xrs3UUN5iG28ZzU7Exl5/3a18sc0iOInqCf+exYtstylLlGnm1NiFBuqUJiERoPPtakeVX4msAsbONXtf66ORKYjgBDIQzPg0JDFoyfneiXHlll4WQT651mcw0fj3YDcPKvL60v8Wp9Kxsaw=="
        desc = "work"
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
