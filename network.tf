resource "aws_internet_gateway" "eks-lab-igw" {
    vpc_id = "${aws_vpc.eks-lab-vpc.id}"
    tags {
        Name = "eks-lab-igw"
    }
}

resource "aws_route_table" "eks-lab-public-crt" {
    vpc_id = "${aws_vpc.eks-lab-vpc.id}"
    
    route {
        cidr_block = "0.0.0.0/0" 
        gateway_id = "${aws_internet_gateway.eks-lab-igw.id}" 
    }
    
    tags = {
    	Name = "eks-lab"
    	Terraform = "true"
    	Turbonomic = "true"
  	}
}

