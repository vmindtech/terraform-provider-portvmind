# Password authentication. Set exactly one of tenant_name or project_id.

provider "portvmind" {
  endpoint         = "https://<region>-apigw.portvmind.com/vke/api/v1"
  auth_url         = "https://<region>-apigw.portvmind.com"
  user_name        = "<user_name>"
  password         = "<password>"
  user_domain_name = "Default"

  # tenant_name = "<tenant_name>"
  project_id = "<portvmind_cloud_project_id>"
}
