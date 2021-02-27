data "template_file" "cloud_init" {
  template = file("${path.module}/add-user.sh")

}
