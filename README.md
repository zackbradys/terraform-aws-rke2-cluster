# Terraform Module for RKE2 on AWS

WIP WIP WIP WIP WIP

## Prerequisites
* Git Utility, Terminal Utility, and HashiCorp Terraform with Access to the AWS Provider
* AWS Commercial or AWS GovCloud Account with an Access Key and Secret Key
* Ability to Subscribe to the [AWS Marketplace Listing for the AMI for Rocky 9](https://aws.amazon.com/marketplace/pp/prodview-ygp66mwgbl2ii) or use your own AWS AMI.

## Configuration

### Step 1
Add the module code to `main.tf` and set the required variables or additional optional variables!
```bash
module "rke2-cluster" {
  source  = "zackbradys/rke2-cluster/aws"
  version = "0.1.0"

  region        = var.region
  access_key    = var.access_key
  secret_key    = var.secret_key
  key_pair_name = var.key_pair_name
  domain        = var.domain
  prefix        = var.prefix
}
```

### Step 2
Add the following code to your `terraform.tfvars` and input your variables.
```bash
### (Required) The AWS Region to use for the instance(s).
region = ""

### (Required) The AWS Access Key to use for the instance(s).
access_key = ""

### (Required) The AWS Secret Key to use for the instance(s).
secret_key = ""

### (Required) The AWS Key Pair name to use for the instance(s).
key_pair_name = ""

### (Required) The AWS Route53 domain to use for the cluster(s).
domain = ""

### (Required) The prefix/name for all provisioned resources.
prefix = ""
```

### Step 3
Run the terraform commands to deploy and provision your infrastructure!
```bash
terraform init

terraform plan

terraform apply --auto-approve

terraform output
```

### Contributing
Please utilize GitHubs features such as Issues, Forks, and Pull Requests to contribute to this code!

### About Me
A little bit about me, my history, and what I've done in the industry. If you have any questions, please reach out to me on my GitHub (https://github.com/zackbradys)!
- DOD/IC Contractor
- U.S. Military Veteran
- Open-Source Contributor
- Built and Exited a Digital Firm
- Active Volunteer Firefighter/EMT