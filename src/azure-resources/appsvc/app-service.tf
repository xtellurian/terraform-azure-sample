resource "random_id" "server" {
  keepers = {
    azi_id = 1
  }

  byte_length = 8
}

variable "appsvc_location" {
  type = "string"
}

variable "name" {
  type = "string"
}

resource "azurerm_resource_group" "appsvc-rg" {
  name     = "${var.name}"
  location = "${var.appsvc_location}"
}

resource "azurerm_app_service_plan" "appsvc-plan" {
  name                = "${var.name}-plan"
  location            = "${azurerm_resource_group.appsvc-rg.location}"
  resource_group_name = "${azurerm_resource_group.appsvc-rg.name}"

  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "appsvc" {
  name                = "${var.name}-${random_id.server.hex}"
  location            = "${azurerm_resource_group.appsvc-rg.location}"
  resource_group_name = "${azurerm_resource_group.appsvc-rg.name}"
  app_service_plan_id = "${azurerm_app_service_plan.appsvc-plan.id}"

  site_config {
    dotnet_framework_version = "v4.0"
    scm_type                 = "LocalGit"
  }

  app_settings {
    "SOME_KEY" = "some-value"
  }

  connection_string {
    name  = "Database"
    type  = "SQLServer"
    value = "Server=some-server.mydomain.com;Integrated Security=SSPI"
  }
}
