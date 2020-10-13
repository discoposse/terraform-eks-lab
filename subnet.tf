resource "aws_subnet" "eks-lab-pub" {
	count = 3
    vpc_id = aws_vpc.eks-lab-vpc.id
    cidr_block = "10.0.${count.index}.0/24"
    map_public_ip_on_launch = "true"
    availability_zone = "${var.aws_region}${var.az_map[count.index]}"

    tags = {
    	Name = "eks-lab"
    	Terraform = "true"
    	Turbonomic = "true"
    	"kubernetes.io/cluster/eks-lab" = "shared"
    	"kubernetes.io/role/elb" = "1"
        net = "public"
  	}
}

resource "aws_subnet" "eks-lab-priv" {
	count = 3
    vpc_id = aws_vpc.eks-lab-vpc.id
    cidr_block = "10.0.10${count.index}.0/24"
    map_public_ip_on_launch = "false"
    availability_zone = "${var.aws_region}${var.az_map[count.index]}"

    tags = {
    	Name = "eks-lab"
    	Terraform = "true"
    	Turbonomic = "true"
    	"kubernetes.io/cluster/eks-lab" = "shared"
    	"kubernetes.io/role/internal-elb" = "1"
        net = "private"
  	}
}
