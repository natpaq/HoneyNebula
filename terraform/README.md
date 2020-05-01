# T-Pot Terraform
We've completely recoded the original [Terraform](https://www.terraform.io/) configuration in order to deploy the infrastructure used in our studies. T-Pot does provide Terraform code but it is all specialized for either AWS or OTC. Since we were on GCP, our deployment patterns were much more different due to the odd behavior exhibited by the platform when provided with a cloud-init.yaml file. This document outlines the changes and requirements for deploying  your own copy of the T-pot architecture on GCP for replication/research/learning purposes.

## Deployed Infrastructure Nodes
The deployment offers a complete setup of T-Pot based on their installation script but reconfigures a couple containers and important data ingress/egress between containers. 

You'll need to make the changes found under the _configuration_ section of this document. 

The setup will deploy a master node (Called Honeycore) which acts as an aggregate for all of the other honeypots' outputs and will deploy any number of honeypots. The amount of honeypots and their names + regions are configured in the `gcp/variables.auto.tfvars` file. Terraform will also link all the VMs together on one VPC network and uses internal (intranetwork) communication so as to avoid the overhead and risk of sending data across the internet. This way, we can leverage GCP and transfer data on Google's networks for as long as possible.

## Configuration
There are two main configurations to change when attempting to deploy an example infrastructure:
- `gcp/main.tf`: within the provider block, the credentials and project need to be changed to point to your project of choice, and credentials file or another form of authentication outlined in [Google's Authentication Procedures for GCP](https://cloud.google.com/docs/authentication)
- `gcp/variables.auto.tfvars`: within the honeypot_regionmap block, you'll need to add/remove entries in order to define which mchines acting as honeypots will be deployed. The format follows `name`=`geographical_zone` with name matching the regex format: `[a-z]([-a-z0-9]*[a-z0-9])?` 

# Deployment
Once everything is configured and the required changes have been made, you can then deploy the infrastructure with Terraform by going into the `gcp` folder and running `terraform init`, `terraform apply`. The apply command will ask you to confirm the changes it will make, alongside an outline of the changes to be made before deploying. You may optionally run `terraform plan` to show what the changes will be before deployment. This is equivalent to running the apply command but without the ability to deploy after. 

# What will Terraform Do?
Terraform will instantiate a Honeycore and honeypots. Once the instances have been created, Terraform will then connect to the VMs on port 22 to begin configuring T-Pot. T-Pot will install on the "standard" setup. Once that is complete, it will be instructed to restart after which, the new configured SSH port into the actual VMs will be through management port `64295` (Remember that 22 is now a honeypot port). Terraform will also reconfigure the ElasticSearch container and logstash configuration file to output data to the honeycore VM instead of storing files locally on each honeypot. 
