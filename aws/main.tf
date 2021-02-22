# From https://blog.zhenkai.xyz/terraforming-wordpress-on-aws-lightsail/
# From https://github.com/castironclay/aws_lightsail_wireguard


terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
  backend "remote" {
    organization = "LVTechnologies"

    workspaces {
      name = "github-actions"
    }
  }
}

provider "template" {}
provider "tls" {}

provider "aws" {
  #shared_credentials_file = file(var.credentials_file)
  profile = var.profile
  region  = var.region
}

## Creates an AWS Lightsail Instance.
# Adding firewall thanks to https://stackoverflow.com/a/60388340/5107192
resource "aws_lightsail_instance" "lightsail_instance" {
  name              = "terraform-instance" ## Name of lightsail instance in AWS
  availability_zone = var.zone
  blueprint_id      = var.lightsail_blueprints["ubuntu20"] ## Options for "wordpress", "wordpress_multi" or "nginx"
  bundle_id         = var.lightsail_bundles["dev"]         ## Options for instance size
  key_pair_name     = aws_lightsail_key_pair.key.name
  depends_on        = [aws_lightsail_key_pair.key]
  user_data         = data.template_file.cloud_init.rendered

  provisioner "local-exec" {
    command = "aws lightsail put-instance-public-ports --region ${var.region} --instance-name=terraform-instance --port-infos fromPort=22,toPort=22,protocol=tcp fromPort=8090,toPort=8090,protocol=tcp fromPort=1883,toPort=1883,protocol=tcp fromPort=80,toPort=80,protocol=tcp"
  }
}

## Creates a static public IP address on Lightsail
resource "aws_lightsail_static_ip" "static_ip" {
  name = "static_ip_name" ## Name of static IP in AWS
}

## Attaches static IP address to Lightsail instance
resource "aws_lightsail_static_ip_attachment" "static_ip_attach" {
  static_ip_name = aws_lightsail_static_ip.static_ip.id
  instance_name  = aws_lightsail_instance.lightsail_instance.id
}
