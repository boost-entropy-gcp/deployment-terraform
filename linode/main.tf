
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

  stackscript_id = linode_stackscript.add_user.id
  stackscript_data = {
    "username" = var.username
  }
  depends_on = [linode_sshkey.key]
}

