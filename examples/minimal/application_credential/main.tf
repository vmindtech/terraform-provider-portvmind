# Example: VKE provider with OpenStack application credentials (no user/password).
# Do not set user_name, password, user_domain_name, or tenant_name when using this mode.
# Pass values via TF_VAR_* or a gitignored *.tfvars file.

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

variable "vke_application_credential_id" { type = string }
variable "vke_application_credential_secret" {
  type      = string
  sensitive = true
}

provider "vke" {
  endpoint   = var.vke_endpoint
  auth_url   = var.vke_auth_url

  application_credential_id     = var.vke_application_credential_id
  application_credential_secret = var.vke_application_credential_secret
}

# data "vke_cluster" "example" {
#   cluster_id = "..."
# }
