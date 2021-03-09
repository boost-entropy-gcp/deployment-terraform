terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "3.59.0"
    }
  }
  backend "remote" {
    organization = "LVTechnologies"

    workspaces {
      name = "github-actions-gcp"
    }
  }
}

provider "template" {}
provider "tls" {}

provider "google" {

  credentials = file(var.credentials_file)

  project = var.project
  region  = var.region
  zone    = var.zone
}

resource "google_compute_network" "vpc_network" {
  name = "terraform-network"
}

resource "google_compute_address" "vm_static_ip" {
  name = "terraform-static-ip"
}

resource "google_compute_firewall" "vpc-firewall-out" {
  name    = "vpc-firewall-out"
  network = google_compute_network.vpc_network.name
  project = var.project

  allow {
    protocol = "tcp"
    ports    = ["80", "8080", "9090", "6443", "22", "443", "50000", "1883"]
  }

  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "vpc-firewall-int" {
  name    = "vpc-firewall-int"
  network = google_compute_network.vpc_network.name
  project = var.project
  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "udp"
    ports    = ["0-65535"]
  }

  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }

  source_ranges = ["10.128.0.0/9"]
}

resource "google_compute_instance" "vm_instance" {
  name                      = "terraform-instance"
  machine_type              = var.machine_types[var.environment]
  tags                      = ["dev"]
  allow_stopping_for_update = true

  provisioner "local-exec" {
    command = "echo ${google_compute_instance.vm_instance.name}:  ${google_compute_instance.vm_instance.network_interface[0].access_config[0].nat_ip} >> ip_address.txt"
  }

  boot_disk {
    initialize_params {
      image = var.source_image
    }
  }

  network_interface {
    network = google_compute_network.vpc_network.name
    access_config {
      nat_ip = google_compute_address.vm_static_ip.address
    }
  }
  metadata {
    sshKeys = "${var.gcp_ssh_user}:${gcp_sshkey.key.ssh_key}"
  }

  depends_on = [gcp_sshkey.key]
}


