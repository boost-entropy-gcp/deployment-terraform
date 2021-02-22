output "ip" {
  value = linode_instance_ip.terraform_instance.address
}

output "private_key" {
  value     = tls_private_key.key.private_key_pem
  sensitive = true
}
