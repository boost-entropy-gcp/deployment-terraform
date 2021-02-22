output "ip" {
  value = aws_lightsail_static_ip.static_ip.ip_address
}

output "private_key" {
  value     = tls_private_key.key.private_key_pem
  sensitive = true
}
