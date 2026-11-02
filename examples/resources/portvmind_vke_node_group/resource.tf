resource "portvmind_vke_node_group" "workers_2" {
  cluster_id       = portvmind_vke_cluster.main.id
  name             = "workers-2"
  node_flavor_uuid = "<node_flavor_uuid>"
  node_disk_size   = 50
  min_size         = 1
  max_size         = 4

  # node_group_labels = [
  #   "workload=gpu",
  #   "team=ml",
  # ]
  # node_group_taints = [
  #   "dedicated=worker2:NoSchedule",
  # ]
}
