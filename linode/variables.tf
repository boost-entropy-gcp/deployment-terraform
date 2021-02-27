variable "region" {
  default = "us-east"
}

variable "linode_api_token" {
  type = string
}

variable "root_pass" {
  type = string
}

variable "username" {
  type    = string
  default = "user"
}

variable "label" {
  default = "terraform-instance"
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

variable "linode_types" {
  type = map(any)
  default = {
    dev  = "g6-nanode-1"
    test = "g6-standard-1"
    prod = "g6-standard-2"
  }
}

variable "linode_images" {
  type = map(any)
  default = {
    ubuntu20 = "linode/ubuntu20.04 "
    ubuntu18 = "linode/ubuntu18.04 "
  }
}
