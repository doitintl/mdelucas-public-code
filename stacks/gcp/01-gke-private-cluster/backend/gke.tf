#############################################################################
# GKE                                                                       #
#############################################################################

module "gke" {
  source  = "terraform-google-modules/kubernetes-engine/google//modules/beta-private-cluster"
  version = "~> 23.3"

  project_id         = var.project_id
  name               = var.gke_cluster_name
  regional           = var.gke_cluster_regional
  region             = local.gke_cluster_region
  zones              = local.gke_cluster_zones
  description        = "GKE ${var.gke_cluster_regional ? "regional" : "zonal"} cluster ${var.gke_cluster_name} for stack ${var.stack_name}."
  network            = local.vpc_network_name
  subnetwork         = "subnet-gke-${var.region}"
  ip_range_pods      = "subnet-gke-${var.region}-pods"
  ip_range_services  = "subnet-gke-${var.region}-services"
  kubernetes_version = var.gke_cluster_version
  release_channel    = var.gke_cluster_release_channel


  enable_private_endpoint     = var.gke_cluster_enable_private_endpoint
  enable_private_nodes        = var.gke_cluster_enable_private_nodes
  enable_intranode_visibility = var.gke_cluster_enable_intranode_visibility
  master_ipv4_cidr_block      = var.gke_cluster_master_ipv4_cidr_block
  master_authorized_networks  = local.gke_master_authorized_networks
  enable_identity_service     = var.gke_enable_identity_service
  default_max_pods_per_node   = var.gke_cluster_default_max_pods_per_node
  network_policy              = var.gke_cluster_enable_network_policy
  # deploy_using_private_endpoint = true

  http_load_balancing             = true
  horizontal_pod_autoscaling      = var.gke_cluster_enable_horizontal_pod_autoscaling
  enable_vertical_pod_autoscaling = var.gke_cluster_enable_vertical_pod_autoscaling
  gce_pd_csi_driver               = true


  filestore_csi_driver    = false
  istio                   = false
  cloudrun                = false
  dns_cache               = false
  gke_backup_agent_config = false

  node_pools               = var.gke_cluster_node_pools
  remove_default_node_pool = var.gke_cluster_remove_default_node_pool

  node_pools_oauth_scopes = {
    all = [
      "https://www.googleapis.com/auth/cloud-platform",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }

  node_pools_labels = {
    all = {}
  }

  node_pools_metadata = {
    all = {}
  }

  node_pools_taints = {
    all = []
  }

  node_pools_tags = {
    all = []
  }
}