resource "linode_stackscript" "add_user" {
  label       = "user"
  description = "Add init user"
  script      = data.template_file.could_init.rendered
  images      = [var.linode_images["ubuntu20"], var.linode_images["ubuntu18"]]
  rev_note    = "initial version"
}
