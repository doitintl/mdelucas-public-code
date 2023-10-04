# Terraform stack for 01 GKE Private Cluster


## Prerequisites
* [Terraform 0.13+](https://developer.hashicorp.com/terraform/downloads) Tool that manages IaC (infrastructure-as-code) in diverse public cloud providers and tools.
* [terraform-docs](https://github.com/terraform-docs/terraform-docs/releases/) Generate documentation for Terraform stacks.
* [tflint](https://github.com/terraform-linters/tflint) Linter for Terraform stacks. Linting rules for diverse public providers.
* [pre-commit](https://pre-commit.com/) A framework for managing and maintaining multi-language pre-commit hooks.
* [Google Cloud CLI](https://cloud.google.com/sdk/docs/install) Google Cloud Command Line Interface.
* [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/) The Kubernetes command-line tool, kubectl, allows you to run commands against Kubernetes clusters.

## Install

This PoC is composed of three layers.
You must apply them in this order and destroy them in reverse order.

1. [Baseline stack](./baseline/README.md) with application infrastructure. VPC and subnets.
2. [Backend layer](./backend/README.md) with application infrastructure. GKE cluster, NAT router, IAP bastion instance and subnet.



