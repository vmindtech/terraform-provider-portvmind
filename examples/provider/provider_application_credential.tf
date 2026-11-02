# Application credential authentication.
# Do not set user_name, password, user_domain_name, tenant_name, or project_id.

provider "portvmind" {
  endpoint = "https://<region>-apigw.portvmind.com/vke/api/v1"
  auth_url = "https://<region>-apigw.portvmind.com"

  application_credential_id     = "<app_cred_id>"
  application_credential_secret = "<app_cred_secret>"
}
