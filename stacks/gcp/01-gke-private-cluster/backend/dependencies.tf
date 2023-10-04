#############################################################################
# Stack dependencies                                                        #
#############################################################################

data "terraform_remote_state" "baseline" {
  backend = "gcs"
  config = {
    bucket = "04a17e60ca0de333-tf-state-bucket"
    prefix = "stacks/gcp/01-gke-private-cluster/baseline"
  }
}

data "google_compute_zones" "available" {
  region = var.region
  status = "UP"
}
