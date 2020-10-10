resource "aws_vpc" "eks-lab-vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "eks-lab"
    Terraform = "true"
    Turbonomic = "true"
  }
}