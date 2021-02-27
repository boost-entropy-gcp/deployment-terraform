resource "linode_stackscript" "add_user" {
  label       = "user"
  description = "Add init user"
  script      = file("${path.module}/add-user.sh")
  images      = [var.linode_images["ubuntu20"], var.linode_images["ubuntu18"]]
  rev_note    = "initial version"
}
