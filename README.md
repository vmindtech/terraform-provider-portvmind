# Terraform Provider: VMind Kubernetes Engine (VKE)

Official Terraform provider for [VMind Kubernetes Engine (VKE)](https://github.com/vmindtech/vke). It obtains an OpenStack Keystone token and sends it to the VKE API as `X-Auth-Token`.

## Requirements

- Terraform 1.0+
- Go 1.22+ (for development)

## Usage (Terraform Registry)

After the provider is published:

```hcl
terraform {
  required_providers {
    vke = {
      source  = "vmindtech/vke"
      version = "~> 0.1"
    }
  }
}

provider "vke" {
  endpoint = "https://YOUR-VKE-API/api/v1"
  auth_url = "https://YOUR-KEYSTONE:5000/v3"

  # Option A: password (same variables as the OpenStack provider)
  user_name        = var.user_name
  password         = var.password
  user_domain_name = var.user_domain_name
  tenant_name      = var.project_name

  # Option B: application credential (do not set password fields)
  # application_credential_id     = var.app_cred_id
  # application_credential_secret = var.app_cred_secret
}
```

## Publishing and testing via the Registry

1. Host the repository at **`github.com/vmindtech/terraform-provider-vke`** (or keep `go.mod` consistent with your module path).
2. Sign in to the [Terraform Registry](https://registry.terraform.io/sign-in) → **Publish** → Provider → connect GitHub; namespace `vmindtech`, provider name `vke`.
3. **GPG signing:** [Signing keys](https://developer.hashicorp.com/terraform/registry/providers/publishing#preparing-and-gpg-signing) — add your GPG key in the Registry. For the first release you can try without signing; if the Registry requires it, uncomment the `signs` block in `.goreleaser.yml` and set `GPG_FINGERPRINT` locally.
4. Push a version tag; the GitHub Actions `release` workflow runs GoReleaser and publishes zips and `SHA256SUMS`:

```bash
git tag v0.1.0
git push origin v0.1.0
```

5. After a short delay, `terraform init` will download the provider from the Registry.

## Local build

```bash
go build -o terraform-provider-vke .
```

## Resources

- `vke_cluster` — create/destroy cluster; `kubeconfig` after the cluster is Active
- `vke_node_group` — worker node groups
- `vke_cluster` (data source) — read existing cluster metadata

## Examples

- `examples/minimal/main.tf` — password auth (aligned with the OpenStack provider variables)
- `examples/minimal/application_credential/main.tf` — application credential auth

## License

See `LICENSE`.
