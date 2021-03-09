output "ip" {
  value = google_compute_address.vm_static_ip.address
}

output "private_key" {
  value     = tls_private_key.key.private_key_pem
  sensitive = true
}
