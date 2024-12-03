# Terraform Module for RKE2 on AWS

**Please review the information below and follow the instructions to deploy this module!**

## Prerequisites

- Git Utility, Terminal Utility, and HashiCorp Terraform with Access to the AWS Provider Plugin
- AWS Commercial or AWS GovCloud Account with the appropriate elevated privileges to interact with AWS Services

## Configuration

**Step 1:** Ensure Terraform is installed and create a working directory.

**Step 2:** Copy the code below into a file named `main.tf` and set the required variables or additional optional variables!

```bash
module "rke2-cluster" {
  source  = "zackbradys/rke2-cluster/aws"
  version = "1.3.0"

  region        = "us-east-1"
  access_key    = "ACCESS_KEY_HERE"
  secret_key    = "SECRET_KEY_HERE"
  key_pair_name = "AWS_KEY_PAIR_NAME"
  domain        = "example.com"
  prefix        = "rke2-cluster"
}
```

**Step 3:** Run the commands below to deploy and provision your infrastructure!

```bash
terraform init

terraform plan

terraform apply --auto-approve
```

**Step 4:** Wait about 10 minutes and access your RKE2 Cluster! Typically, users SSH into the nodes via the bastion host to use _kubectl_ on the node or users export the kubeconfig (`/etc/rancher/rke2/rke2.yaml`) to access the cluster and _kubectl_ locally.

### Contributing

Please utilize GitHubs features such as Issues, Forks, and Pull Requests to contribute to this code!

### About Me

A little bit about me and my history in the industry. If you have any questions, please reach out to me at zbrady@zackbrady.com!

- Former Contractor
- U.S. Military Reservist
- Open-Source Contributor
- Built and Exited a Digital Firm
- Active Volunteer Firefighter/EMT
