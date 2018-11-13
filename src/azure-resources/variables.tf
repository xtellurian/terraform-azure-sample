variable "use_msi" {
  type        = "string"
  description = "Use MSI to deploy resources"
}

variable "environment" {
  type        = "string"
  description = "Environment, i.e. prod, dev or local"
}

variable "tenant" {
  type        = "string"
  description = "Azure Tenant Id"
}

variable "subscription" {
  type        = "string"
  description = "Azure Subscription Id"
}

variable "agent_hostname" {
  type        = "string"
  description = "Hostname of the terraform agent"
}

variable "appsvc_location" {
  type        = "string"
  description = "Location of the azure resource group."
  default     = "australiaeast"
}

variable "appsvc_name" {
  type        = "string"
  description = "Name of the app service"
}
