variable "gcloud_account_json" {
  type    = string
}

variable "gcloud_project_id" {
  type    = string
}

# "timestamp" template function replacement
locals { timestamp = regex_replace(timestamp(), "[- TZ:]", "") }

source "googlecompute" "packer" {
  account_file        = "${var.gcloud_account_json}"
  disk_size           = "20"
  image_family        = "docker"
  image_name          = "docker-${local.timestamp}"
  machine_type        = "e2-small"
  project_id          = "${var.gcloud_project_id}"
  source_image_family = "ubuntu-2004-lts"
  ssh_username        = "ubuntu"
  zone                = "us-central1-a"
}

build {
  sources = ["source.googlecompute.packer"]

  provisioner "shell" {
    script = "./install-docker.sh"
  }
}
