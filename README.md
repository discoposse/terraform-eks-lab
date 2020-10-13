# Terraform AWS EKS Lab

This is a ground (or cloud) up deployment of an AWS EKS environment which can be used to build quick lab environments and easily tear them down for a true self-cleaning on-demand Kubernetes configuration.

## Why does this exist?

Setting up EKS for occasional use is not simple, nor is making sure you have all the dependencies, policies, networks, and more.  It's also easy to leave behind a lot of remnants in AWS which are either costly or confusing (e.g. empty policies, unused subnets)

## Requirements

You will need:
* AWS IAM credentials - currently using root credentials (which is not ideal)
* Terraform Cloud our Terraform Enterprise account


## About the Lab Code

Terraform configuration built for Terraform 0.13.4 or higher

## What Does the EKS Lab Build?

The lab does the following which is also completely removed when you do a deprovision/destroy so you have no unnecessary remnants left behind:

* Create new IAM for EKS/EC2
* Set up new VPC
* Create 3 public subnets
* Create 3 private subnets
* Create Security Groups for ingress and egress
* Create an Internet Gateway
* Create a Routing Table and Subnet Associations
* Create an EKS Cluster
* Create an EKS Node Group

## Variables Needed for Terraform

You will need to have the following defined in your Terraform configuration. This was built using Terraform Cloud and Terraform Enterprise so the description 

| Variable  | Type | Content |
| ------------- | ------------- | ------------- |
| aws_access_key | sensitive | Your AWS programmatic API key |
| aws_secret_key | sensitive | Your AWS API secret key |
| aws_region | standard | Region to launch in (e.g. us-east-2) |
| aws_key_name | text | Display name of your SSH key in AWS |
| aws_key_fingerprint | text | SSH key fingerprint (hex format) from AWS |
| aws_certificate_arn | text | ACM certificate ARN for TLS (not used yet) |
| allowed_ip_network | HCL | Ingress networks for http/https/ssh using HCL format (e.g. ["0.0.0.0/0","10.0.0.0/16"] |
| eks_node_min | numeric | Minimum number of EKS compute nodes (>=1) |
| eks_node_max | numeric | Maximum number of EKS compute nodes |
| eks_node_desired | numeric | Desired number of EKS nodes |

## Terraform Cloud Settings / Preferences

This was built using a VCS-backed configuration using GitHub using the very repository you're forking this from. 

Execution Mode is set to Auto Apply.  In order to keep things from running every time documention or non-infra files are updated, there is a `trigger.txt` file which can be used as a way to force an apply. 
