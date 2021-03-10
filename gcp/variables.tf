variable "project" {}

variable "region" {
  default = "us-central1"
}

variable "gcp_ssh_user" {
  default = "user"
}

variable "zone" {
  type    = string
  default = "us-central1-c"
}

variable "web_instance_count" {
  type    = number
  default = 1
}

variable "cidrs" { default = [] }

variable "environment" {
  type    = string
  default = "dev"
}


variable "machine_types" {
  type = map(any)
  default = {
    dev  = "e2-small"
    test = "n1-highcpu-32"
    prod = "n1-highcpu-32"
  }
}

variable "source_image" { default = "docker" }
