
terraform {
  required_providers {
    linode = {
      source  = "linode/linode"
      version = "1.14.3"
    }
  }
  backend "remote" {
    organization = "LVTechnologies"

    workspaces {
      name = "github-actions-linode"
    }
  }
}

provider "template" {}
provider "tls" {}

provider "linode" {
  token = var.linode_api_token
}

resource "linode_instance" "terraform_instance" {
  label           = var.label
  image           = var.linode_images["ubuntu20"]
  region          = var.region
  type            = var.linode_types["dev"]
  authorized_keys = [linode_sshkey.key.ssh_key]
  root_pass       = var.root_pass

  depends_on = [linode_sshkey.key]
}

resource "linode_instance_ip" "terraform_instance" {
  linode_id = linode_instance.terraform_instance.id
  public    = true
}

