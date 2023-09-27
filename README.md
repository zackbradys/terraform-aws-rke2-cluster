# Terraform Module for RKE2 on AWS

WIP WIP WIP WIP WIP

## Prerequisites
* Git Utility, Terminal Utility, and HashiCorp Terraform with Access to the AWS Provider
* AWS Commercial or AWS GovCloud Account with an Access Key and Secret Key
* Ability to Subscribe to the [AWS Marketplace Listing for the AMI for Rocky 9](https://aws.amazon.com/marketplace/pp/prodview-ygp66mwgbl2ii) or use your own AWS AMI.

## Configuration

**Step 1:** Ensure Terraform is installed and create a working directory.

**Step 2:** Copy the code below into a file named `main.tf` and set the required variables or additional optional variables!
```bash
module "rke2-cluster" {
  source  = "zackbradys/rke2-cluster/aws"
  version = "0.3.1"

  region        = ""
  access_key    = ""
  secret_key    = ""
  key_pair_name = ""
  domain        = ""
  prefix        = ""
}
```

**Step 3:** Run the commands below to deploy and provision your infrastructure!
```bash
terraform init

terraform plan

terraform apply --auto-approve
```

### Contributing
Please utilize GitHubs features such as Issues, Forks, and Pull Requests to contribute to this code!

### About Me
A little bit about me, my history, and what I've done in the industry. If you have any questions, please reach out to me on my GitHub (https://github.com/zackbradys)!
- Former Contractor
- U.S. Military Veteran
- Open-Source Contributor
- Built and Exited a Digital Firm
- Active Volunteer Firefighter/EMT