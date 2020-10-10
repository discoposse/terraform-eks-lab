variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "aws_region" {}
variable "aws_vpc_id" {}
variable "aws_key_name" {}
variable "aws_key_fingerprint" {}
variable "aws_certificate_arn" {}
variable "aws_launch_subnet" {}
variable "terraform_workspace" {
	default = "terraform-eks-lab"
}

variable "terraform_organization" {
	default = "turbonomiclabs"
}