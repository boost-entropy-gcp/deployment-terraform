#variable "credentials_file" {}

variable "region" {
  default = "us-east-1"
}

variable "zone" {
  default = "us-east-1a"
}

variable "profile" {
  type    = string
  default = "default"
}

variable "cidrs" { default = [] }

variable "environment" {
  type    = string
  default = "dev"
}

variable "lightsail_bundles" {
  type = map(any)
  default = {
    dev  = "small_2_0"
    test = "small_2_0"
    prod = "medium_2_0"
  }
}


variable "source_image" { default = "docker-java" }
variable "lightsail_blueprints" {
  type = map(any)
  default = {
    ubuntu20 = "ubuntu_20_04"
    ubuntu18 = "ubuntu_18_04"
  }
}
