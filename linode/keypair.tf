resource "tls_private_key" "key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "linode_sshkey" "key" {
  label      = "key"
  ssh_key    = chomp(tls_private_key.key.public_key_openssh)
  depends_on = [tls_private_key.key]
}
