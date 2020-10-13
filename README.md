# Terraform EKS Lab

This is a ground (or cloud) up deployment of an AWS EKS environment which can be used to build quick lab environments and easily tear them down for a true self-cleaning on-demand Kubernetes configuration.

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


