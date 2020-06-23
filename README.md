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
  source            = "<module_path>"
  name              = "customer-orders"
  hazelcast_version = "3.12.7"
  cluster_members   = 3
  cpu               = "500m"
  memory            = "200Mi"
  labels = {
    created-by = "terraform"
    purpose    = "example"
  }
}
```

## Examples

Try out the module functionality with the example defined [https://github.com/everest-engineering/terraform-kubernetes-hazelcast/blob/master/examples/main.tf](https://github.com/everest-engineering/terraform-kubernetes-hazelcast/blob/master/examples/main.tf)

1. Switch to examples directory `cd examples`
2. Initialize Terraform to download required plugins `terraform init`
3. Run `plan` to find out all resources that are going to be created `terraform plan`
4. Run `apply` to create those resources `terraform apply`
5. Deploy a hazelcast client pod and verify the connection. More on that at #clients section
6. Make sure to destroy them once you are done exploring using `terraform destroy`

## Connecting to the Hazelcast cluster running inside Kubernetes

Hazelcast supports two strategies to simplify the deployment in a Kubernetes cluster.
Official documentation is at [https://github.com/hazelcast/hazelcast-kubernetes#understanding-discovery-modes](https://github.com/hazelcast/hazelcast-kubernetes#understanding-discovery-modes)

This module uses the `DNS Lookup` strategy to form a cluster. So, the client should also use this strategy to connect to the cluster. 

### Example Hazelcast java client project

Here is a sample test client written in java [https://github.com/everest-engineering/terraform-kubernetes-hazelcast/blob/master/tests/hazelcast-java-client](https://github.com/everest-engineering/terraform-kubernetes-hazelcast/blob/master/tests/hazelcast-java-client)

As of now (on 23rd June 2019) only the java Hazelcast client implmentation supports kubernetes discovery using the plugin [https://github.com/hazelcast/hazelcast-kubernetes](https://github.com/hazelcast/hazelcast-kubernetes)

You can verify the feature completeness for your favourite langauge at [https://hazelcast.org/imdg/clients-languages/](https://hazelcast.org/imdg/clients-languages/)

## Inputs

| Name               | Description                       | Type          | Default       | Required |
| ------------------ | --------------------------------- | ------------- | ------------- | :------: |
| cluster\_members   | number of members in the cluster  | `number`      | `1`           |    no    |
| cpu                | cpu units to request              | `string`      | n/a           |   yes    |
| hazelcast\_version | hazelcast version to deploy       | `string`      | n/a           |   yes    |
| labels             | labels to apply to all resources  | `map(string)` | n/a           |   yes    |
| memory             | amount of memory to request       | `string`      | n/a           |   yes    |
| name               | name of the cluster               | `string`      | `"hazelcast"` |    no    |
| namespace          | kubernetes namespace to deploy to | `string`      | `"default"`   |    no    |

## Outputs

| Name         | Description                                       |
| ------------ | ------------------------------------------------- |
| service\_dns | fully qualified dns name of the hazelcast service |


## Testing the module

Install minikube from [here](https://kubernetes.io/docs/tasks/tools/install-minikube/) and start a kubernetes cluster in local

### Setup

1. Test setup is automated in [setup.sh](https://github.com/everest-engineering/terraform-kubernetes-hazelcast/blob/master/tests/setup.sh). The shell script does the following tasks.
   * deploys the example hazelcast cluster 
   * verifies that the cluster has formed successfully
   * builds the client project jar
   * builds a docker image using the above jar in Minikube
   * deploys a kubernetes job to run the client in the cluster
   * verifies that client has connected to the cluster successfully

### Tear down
1. Use the script [teardown.sh](https://github.com/everest-engineering/terraform-kubernetes-hazelcast/blob/master/tests/teardown.sh) to remove all test resources

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