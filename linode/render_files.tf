data "template_file" "cloud_init" {
  template = file("${path.module}/add_user.sh")

}
