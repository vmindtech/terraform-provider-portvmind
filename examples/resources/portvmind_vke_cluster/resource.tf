resource "portvmind_vke_cluster" "main" {
  # Optional when provider.project_id is set. Required for tenant_name or application credential auth.
  # project_id = "<portvmind_cloud_project_id>"

  name               = "terraform-cluster"
  kubernetes_version = "v1.35.2+rke2r1"

  node_key_pair_name = "<keypair_name>"
  cluster_api_access = "public"
  subnet_ids = [
    "<subnet_uuid>",
  ]

  worker_node_group_min_size  = 2
  worker_node_group_max_size  = 3
  worker_instance_flavor_uuid = "<worker_flavor_uuid>"
  master_instance_flavor_uuid = "<master_flavor_uuid>"
  worker_disk_size_gb         = 50
  allowed_cidrs               = ["0.0.0.0/0"]
}
