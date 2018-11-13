provider "azurerm" {
  # version = ">=1.12.0"
  use_msi         = "${var.use_msi}"
  tenant_id       = "${var.tenant}"
  subscription_id = "${var.subscription}"
}

provider "random" {
  version = "~> 2.0"
}
