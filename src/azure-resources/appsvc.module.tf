module "appsvc" {
  source = "./appsvc"

  appsvc_location = "${var.appsvc_location}"
  name            = "${var.appsvc_name}"
}
