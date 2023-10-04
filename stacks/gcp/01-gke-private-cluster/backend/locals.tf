#############################################################################
# Locals                                                                    #
#############################################################################

locals {
  vpc_network_id                 = data.terraform_remote_state.baseline.outputs.vpc_network_id
  vpc_network_name               = data.terraform_remote_state.baseline.outputs.vpc_network_name
  gke_cluster_zones              = var.gke_cluster_regional ? data.google_compute_zones.available.names : [var.zone]
  gke_cluster_region             = var.gke_cluster_regional ? var.region : null
  gke_master_authorized_networks = var.gke_cluster_enable_private_endpoint ? [{ display_name = "allow-iap", cidr_block = var.iap_proxy_subnet_cidr_range }] : var.gke_cluster_master_authorized_networks
}