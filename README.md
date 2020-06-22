This module is part of a project to simplify the provisioning of Hazelcast on Kubernetes using Terraform. You may also wish to consider [one of the other approaches](https://github.com/everest-engineering/terraform-aws-hazelcast).

# Terraform module to provision Hazelcast on Kubernetes

This module creates the following resources required to provision Hazelcast 

1. Deployment resource
2. Service resource

### Approach:

![Architecture](https://github.com/everest-engineering/terraform-kubernetes-hazelcast/blob/master/diagrams/hazelcast_on_kubernetes.png?raw=true)

## Prerequisites

1. Install Terraform from [here](https://learn.hashicorp.com/terraform/getting-started/install.html)
2. Allow terraform to access the kubernetes master using by following [https://www.terraform.io/docs/providers/kubernetes/index.html](https://www.terraform.io/docs/providers/kubernetes/index.html) 

## Usage

**Note:**
Change the inputs to match your requirement.

```hcl
module "hazelcast" {
  source            = "<path_to_module>"
  name              = "customer-orders"
  hazelcast_version = "3.11.7"
  labels = {
    CreatedBy = "terraform"
    Purpose   = "testing"
  }
}
```

## Examples

Try out the module functionality with an example defined [here](examples/single-node/main.tf).

1. Switch to examples directory `cd examples`
2. Initialize Terraform to download required plugins `terraform init`
3. Run `plan` to find out all resources that are going to be created `terraform plan`
4. Run `apply` to create those resources `terraform apply`
5. Deploy a hazelcast client pod and use the `service_name` to connect to it  
6. Make sure to destroy them once you are done exploring `terraform destroy`

## Inputs

| Name              | Description                                |  Type  |   Default   | Required |
| ----------------- | ------------------------------------------ | :----: | :---------: | :------: |
| name              | The name of the deployment                 | string | `hazelcast` |   yes    |
| hazelcast_version | Hazelcast version to deploy                | string |    `n/a`    |   yes    |
| cpu               | Cpu units to request for the Hazelcast pod | string |     `1`     |    no    |
| memory            | Memory to request for the Hazelcast pod    | string |    `1Gi`    |    no    |
| labels            | labels to apply to all resources           | string |    `n/a`    |   yes    |

## Outputs

| Name         | Description                         |
| ------------ | ----------------------------------- |
| service_name | Hazelcast service name (cluster ip) |

## Contributing

We appreciate your help!

[Open an issue](https://github.com/everest-engineering/terraform-kubernetes-hazelcast/issues/new/choose) or submit a pull request for an enhancement.
Browse through the
[current open issues](https://github.com/everest-engineering/terraform-kubernetes-hazelcast/issues).

## License

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

## Authors

[![Alt text](https://github.com/everest-engineering/terraform-kubernetes-hazelcast/blob/master/diagrams/banner.png?raw=true)](https://everest.engineering)

[![License: EverestEngineering](https://img.shields.io/badge/Copyright%20%C2%A9-EVERESTENGINEERING-blue)](https://everest.engineering)