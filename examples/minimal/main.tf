# Example: password authentication.
# For application credentials, see: examples/minimal/application_credential/
# Pass credentials via TF_VAR_* or a gitignored *.tfvars file.

terraform {
  required_providers {
    portvmind = {
      source  = "vmindtech/portvmind"
      version = "~> 0.1"
    }
  }
}

variable "portvmind_endpoint" { type = string }
variable "portvmind_auth_url" { type = string }

variable "portvmind_user_name" { type = string }
variable "portvmind_password" { type = string sensitive = true }
variable "portvmind_user_domain_name" { type = string }

# PortvMind Cloud project: set exactly one of project name or project ID.
variable "portvmind_tenant_name" {
  type        = string
  default     = ""
  description = "PortvMind Cloud project name."
}
variable "portvmind_project_id" {
  type        = string
  default     = ""
  description = "PortvMind Cloud project ID (alternative to portvmind_tenant_name)."
}

provider "portvmind" {
  endpoint         = var.portvmind_endpoint
  auth_url         = var.portvmind_auth_url
  user_name        = var.portvmind_user_name
  password         = var.portvmind_password
  user_domain_name = var.portvmind_user_domain_name
  tenant_name      = var.portvmind_project_id == "" ? var.portvmind_tenant_name : null
  project_id       = var.portvmind_project_id != "" ? var.portvmind_project_id : null
}

# data "portvmind_cluster" "example" {
#   cluster_id = "..."
# }
