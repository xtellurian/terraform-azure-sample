variable "use_msi" {
  type        = "string"
  description = "Use MSI to deploy resources"
  default     = "false"
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

variable "dev_suffix" {
  type    = "string"
  default = ""
}
