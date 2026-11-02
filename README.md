# Terraform Provider: PortvMind

Use the PortvMind Terraform Provider to manage PortvMind cloud services with Terraform.

## Requirements

- Terraform `>= 1.0`

## Supported resources

- `portvmind_vke_cluster`: Create/delete VKE clusters and generate `kubeconfig`
- `portvmind_vke_node_group`: Create/update/delete worker node groups for a cluster
- `data.portvmind_vke_cluster`: Read metadata for an existing cluster

## Provider authentication

The provider authenticates with PortvMind Cloud and sends the token as `X-Auth-Token` to the API.

**Password authentication** — set `user_name`, `password`, and `user_domain_name`, and **exactly one** of the following:

- **`tenant_name`** (and optionally **`project_domain_name`**, default `Default`) — select the PortvMind Cloud project by name.
- **`project_id`** — PortvMind Cloud project ID. Do not set `tenant_name` when using this.

**Application credential** — set `application_credential_id` and `application_credential_secret` only (do not set password fields or `tenant_name` / `project_id`).

**`portvmind_vke_cluster.project_id`** — PortvMind Cloud project ID for the VKE create-cluster API. You can omit it when the provider is configured with **`project_id`**; the cluster then uses that same ID. If you authenticate with **`tenant_name`** only, or with **application credentials**, set `project_id` on the cluster resource explicitly.

## Quick start

The following example is an end-to-end single-file configuration.

```hcl
terraform {
  required_providers {
    portvmind = {
      source  = "vmindtech/portvmind"
      version = "~> 1.0.3"
    }
  }
}

provider "portvmind" {
  endpoint         = "https://<region>-apigw.portvmind.com/vke/api/v1"
  auth_url         = "https://<region>-apigw.portvmind.com"
  user_name        = "<user_name>"
  password         = "<password>"
  user_domain_name = "Default"

  # PortvMind Cloud project: use tenant_name OR project_id (not both)
  # tenant_name = "<tenant_name>"
  project_id = "<portvmind_cloud_project_id>"

  # Option B: application credential (do not use with password auth above)
  # application_credential_id     = "<app_cred_id>"
  # application_credential_secret = "<app_cred_secret>"
}

resource "portvmind_vke_cluster" "main" {
  # project_id is optional when provider.project_id is set (same PortvMind Cloud project)
  name               = "terraform-cluster"
  kubernetes_version = "v1.35.2+rke2r1"

  node_key_pair_name = "<keypair_name>"
  cluster_api_access = "public"
  subnet_ids = [
    "<subnet_uuid>",
  ]

  worker_node_group_min_size   = 2
  worker_node_group_max_size   = 3
  worker_instance_flavor_uuid  = "<worker_flavor_uuid>"
  master_instance_flavor_uuid  = "<master_flavor_uuid>"
  worker_disk_size_gb          = 50
  allowed_cidrs                = ["0.0.0.0/0"] # Restrict in production.
}

resource "portvmind_vke_node_group" "workers_2" {
  cluster_id       = portvmind_vke_cluster.main.id
  name             = "workers-2"
  node_flavor_uuid = "<node_flavor_uuid>"
  node_disk_size   = 50
  min_size         = 1
  max_size         = 4

  # optional
  # node_group_labels = [
  #   "workload=gpu",
  #   "team=ml",
  # ]
  # node_group_taints = [
  #   "dedicated=worker2:NoSchedule",
  # ]
}

output "cluster_id" {
  value = portvmind_vke_cluster.main.id
}

output "cluster_status" {
  value = portvmind_vke_cluster.main.status
}

output "kubeconfig" {
  value     = portvmind_vke_cluster.main.kubeconfig
  sensitive = true
}
```

## Run

```bash
terraform init
terraform plan
terraform apply
```

## Notes

- The `kubeconfig` attribute is returned as a sensitive value.
- Cluster provisioning can take time depending on infrastructure state.
- Restrict `allowed_cidrs` according to your security requirements.
- For **flavor types** (PortvMind Cloud flavor IDs), **supported Kubernetes versions**, and other **region-specific or environment-specific values**, refer to the PortvMind community and documentation at [discuss.portvmind.com](https://discuss.portvmind.com).

## License

See `LICENSE` for details.
