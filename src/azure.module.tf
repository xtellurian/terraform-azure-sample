# comment this module to stop deploying this version
module "azure" {
  source = "./azure-resources"

  tenant         = "${var.tenant}"
  subscription   = "${var.subscription}"
  use_msi        = "${var.use_msi}"
  agent_hostname = "${var.agent_hostname}"
  environment    = "${var.environment}"
  appsvc_name    = "appsvc-v1${var.dev_suffix}"
}
