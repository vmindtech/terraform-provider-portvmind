# Example: password authentication (same inputs as the OpenStack provider).
# For application credentials, see: examples/minimal/application_credential/
# Pass credentials via TF_VAR_* or a gitignored *.tfvars file.

terraform {
  required_providers {
    vke = {
      source  = "vmindtech/vke"
      version = "~> 0.1"
    }
  }
}

variable "vke_endpoint" { type = string }
variable "vke_auth_url" { type = string }

variable "vke_user_name" { type = string }
variable "vke_password" { type = string sensitive = true }
variable "vke_user_domain_name" { type = string }
variable "vke_tenant_name" { type = string }

provider "vke" {
  endpoint         = var.vke_endpoint
  auth_url         = var.vke_auth_url
  user_name        = var.vke_user_name
  password         = var.vke_password
  user_domain_name = var.vke_user_domain_name
  tenant_name      = var.vke_tenant_name
}

# data "vke_cluster" "example" {
#   cluster_id = "..."
# }
