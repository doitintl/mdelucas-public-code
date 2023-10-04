# Public code and IaC examples
<img src="./assets/aws_logo.jpg" width="100" height="100" alt="AWS"><img src="./assets/gcp_logo.png" width="100" height="100" alt="GCP"><img src="./assets/Terraform_Logo.png" width="100" height="100" alt="Terraform">

Public code and IaC examples intended to serve as a base for your own purposes.
They also provide backup material for some blogs when indicated.

## DISCLAIMER
Except as represented in this agreement, all the code in this repository is provided ​“AS IS”. Other than as provided in this agreement, we make no other warranties, express or implied, and hereby disclaims all implied warranties, including any warranty of merchantability and warranty of fitness for a particular purpose.

## Prerequisites
* [Terraform 0.13+](https://developer.hashicorp.com/terraform/downloads) Tool that manages IaC (infrastructure-as-code) in diverse public cloud providers and tools.
* [terraform-docs](https://github.com/terraform-docs/terraform-docs/releases/) Generate documentation for Terraform stacks.
* [tflint](https://github.com/terraform-linters/tflint) Linter for Terraform stacks. Linting rules for diverse public providers.
* [pre-commit](https://pre-commit.com/) A framework for managing and maintaining multi-language pre-commit hooks.


## Terraform stacks
Terraform stacks are normally split between _baseline_ (VPC and Networking) and _backend_ (Compute and Storage resources).

When creating the stack for the ticket:
1. First create the _baseline_ stack.
2. Second create the _backend_ stack.

When destroying the stack for the ticket:
1. First delete the _backend_ stack.
2. Second delete the _baseline_ stack.

