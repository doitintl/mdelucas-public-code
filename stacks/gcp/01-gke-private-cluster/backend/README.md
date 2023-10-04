# Terraform stack for 01 GKE Private Cluster

## Description
Backend stack with application infrastructure.

## Connection to private GKE control plane
* Obtain credentials for GKE cluster.
```
gcloud container clusters get-credentials gke-nap-test --zone europe-west6-a --internal-ip
```

* Start an IAP tunnel to tinyproxy service in IAP instance.
```
gcloud compute start-iap-tunnel  iap-proxy 8888 --local-host-port=localhost:8888 --zone europe-west6-a
```

* Set HTTPS_PROXY environment variable to point to the localhost port of your tunnel.
```
export HTTPS_PROXY=localhost:8888
```

* Set [USE_GKE_GCLOUD_AUTH_PLUGIN](https://cloud.google.com/blog/products/containers-kubernetes/kubectl-auth-changes-in-gke) environment variable.
```
export USE_GKE_GCLOUD_AUTH_PLUGIN=True
```

* Use kubectl as usual.


## Prerequisites
* [Terraform 0.13+](https://developer.hashicorp.com/terraform/downloads) Tool that manages IaC (infrastructure-as-code) in diverse public cloud providers and tools.
* [terraform-docs](https://github.com/terraform-docs/terraform-docs/releases/) Generate documentation for Terraform stacks.
* [tflint](https://github.com/terraform-linters/tflint) Linter for Terraform stacks. Linting rules for diverse public providers.
* [pre-commit](https://pre-commit.com/) A framework for managing and maintaining multi-language pre-commit hooks.
* [Google Cloud CLI](https://cloud.google.com/sdk/docs/install) Google Cloud Command Line Interface.
* [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/) The Kubernetes command-line tool, kubectl, allows you to run commands against Kubernetes clusters.

## Installation
Configure your Terraform *TFVARS* file accordingly. Check the included [sample](./terraform.tfvars.sample)

```
terraform init
terraform plan -out backend.plan
terraform apply backend.plan
```

## Removal
Configure your Terraform *TFVARS* file accordingly. Check the included [sample](./terraform.tfvars.sample)

```
terraform apply -destroy -auto-approve
```



<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_google"></a> [google](#requirement\_google) | ~> 4.0 |
| <a name="requirement_google-beta"></a> [google-beta](#requirement\_google-beta) | ~> 4.0 |
| <a name="requirement_null"></a> [null](#requirement\_null) | ~> 3.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | ~> 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 4.47.0 |
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_gke"></a> [gke](#module\_gke) | terraform-google-modules/kubernetes-engine/google//modules/beta-private-cluster | ~> 23.3 |

## Resources

| Name | Type |
|------|------|
| [google_compute_firewall.iap_tcp_forwarding](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall) | resource |
| [google_compute_instance.iap_proxy](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_instance) | resource |
| [google_compute_router.vpc_router](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_router) | resource |
| [google_compute_router_nat.vpc_router_nat](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_router_nat) | resource |
| [google_compute_subnetwork.subnet_iap](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_subnetwork) | resource |
| [google_compute_zones.available](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/compute_zones) | data source |
| [terraform_remote_state.baseline](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_gke_cluster_default_max_pods_per_node"></a> [gke\_cluster\_default\_max\_pods\_per\_node](#input\_gke\_cluster\_default\_max\_pods\_per\_node) | The maximum number of pods to schedule per node. | `number` | `110` | no |
| <a name="input_gke_cluster_enable_horizontal_pod_autoscaling"></a> [gke\_cluster\_enable\_horizontal\_pod\_autoscaling](#input\_gke\_cluster\_enable\_horizontal\_pod\_autoscaling) | Enable horizontal pod autoscaling addon. | `bool` | `true` | no |
| <a name="input_gke_cluster_enable_intranode_visibility"></a> [gke\_cluster\_enable\_intranode\_visibility](#input\_gke\_cluster\_enable\_intranode\_visibility) | Whether Intra-node visibility is enabled for this cluster. This makes same node pod to pod traffic visible for VPC network. | `bool` | `false` | no |
| <a name="input_gke_cluster_enable_network_policy"></a> [gke\_cluster\_enable\_network\_policy](#input\_gke\_cluster\_enable\_network\_policy) | Enable network policy addon. | `bool` | `false` | no |
| <a name="input_gke_cluster_enable_private_endpoint"></a> [gke\_cluster\_enable\_private\_endpoint](#input\_gke\_cluster\_enable\_private\_endpoint) | Whether the master's internal IP address is used as the cluster endpoint. | `bool` | `false` | no |
| <a name="input_gke_cluster_enable_private_nodes"></a> [gke\_cluster\_enable\_private\_nodes](#input\_gke\_cluster\_enable\_private\_nodes) | Whether nodes have internal IP addresses only. | `bool` | `false` | no |
| <a name="input_gke_cluster_enable_vertical_pod_autoscaling"></a> [gke\_cluster\_enable\_vertical\_pod\_autoscaling](#input\_gke\_cluster\_enable\_vertical\_pod\_autoscaling) | Vertical Pod Autoscaling automatically adjusts the resources of pods controlled by it. | `bool` | `false` | no |
| <a name="input_gke_cluster_master_authorized_networks"></a> [gke\_cluster\_master\_authorized\_networks](#input\_gke\_cluster\_master\_authorized\_networks) | List of master authorized networks. If none are provided, disallow external access (except the cluster node IPs, which GKE automatically whitelists). | `list(object({ cidr_block = string, display_name = string }))` | `[]` | no |
| <a name="input_gke_cluster_master_ipv4_cidr_block"></a> [gke\_cluster\_master\_ipv4\_cidr\_block](#input\_gke\_cluster\_master\_ipv4\_cidr\_block) | The IP range in CIDR notation to use for the hosted master network. | `string` | n/a | yes |
| <a name="input_gke_cluster_name"></a> [gke\_cluster\_name](#input\_gke\_cluster\_name) | GKE cluster name. | `string` | `"test-cluster"` | no |
| <a name="input_gke_cluster_node_pools"></a> [gke\_cluster\_node\_pools](#input\_gke\_cluster\_node\_pools) | List of maps containing node pools. | `list(map(any))` | n/a | yes |
| <a name="input_gke_cluster_regional"></a> [gke\_cluster\_regional](#input\_gke\_cluster\_regional) | Flag to enable a GKE regional cluster. | `bool` | `false` | no |
| <a name="input_gke_cluster_release_channel"></a> [gke\_cluster\_release\_channel](#input\_gke\_cluster\_release\_channel) | The release channel of this cluster. Accepted values are UNSPECIFIED, RAPID, REGULAR and STABLE. Defaults to UNSPECIFIED. | `string` | `"UNSPECIFIED"` | no |
| <a name="input_gke_cluster_remove_default_node_pool"></a> [gke\_cluster\_remove\_default\_node\_pool](#input\_gke\_cluster\_remove\_default\_node\_pool) | Remove default node pool while setting up the cluster. | `bool` | `false` | no |
| <a name="input_gke_cluster_version"></a> [gke\_cluster\_version](#input\_gke\_cluster\_version) | The Kubernetes version of the masters. If set to 'latest' it will pull latest available version in the selected region. | `string` | `"latest"` | no |
| <a name="input_gke_enable_identity_service"></a> [gke\_enable\_identity\_service](#input\_gke\_enable\_identity\_service) | Enable the Identity Service component, which allows customers to use external identity providers with the K8S API. | `bool` | `false` | no |
| <a name="input_iap_proxy_subnet_cidr_range"></a> [iap\_proxy\_subnet\_cidr\_range](#input\_iap\_proxy\_subnet\_cidr\_range) | The range of internal addresses that are owned by IAP proxysubnetwork. | `string` | `null` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | GCP project ID | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | GCP compute region ID | `string` | n/a | yes |
| <a name="input_stack_name"></a> [stack\_name](#input\_stack\_name) | Stack name | `string` | n/a | yes |
| <a name="input_zone"></a> [zone](#input\_zone) | GCP compute zone ID | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->