resource "aws_internet_gateway" "eks-lab-igw" {
    vpc_id = aws_vpc.eks-lab-vpc.id

    tags = {
    	Name = "eks-lab"
    	Terraform = "true"
    	Turbonomic = "true"
  	}
}

resource "aws_route_table" "eks-lab-public-crt" {
    vpc_id = aws_vpc.eks-lab-vpc.id
    
    route {
        cidr_block = "0.0.0.0/0" 
        gateway_id = aws_internet_gateway.eks-lab-igw.id
    }
    
    tags = {
    	Name = "eks-lab"
    	Terraform = "true"
    	Turbonomic = "true"
  	}
}

resource "aws_route_table_association" "priv_sub" {
    count = 3

    subnet_id = aws_subnet.eks-lab-pub[count.index].id
    route_table_id = aws_route_table.eks-lab-public-crt.id

    lifecycle { 
        create_before_destroy = true 
    }

    depends_on = [
        aws_subnet.eks-lab-pub,
        aws_route_table.eks-lab-public-crt,
    ]
 }

 resource "aws_route_table_association" "pub_sub" {
    count = 3

    subnet_id = aws_subnet.eks-lab-priv[count.index].id
    route_table_id = aws_route_table.eks-lab-public-crt.id

    lifecycle { 
        create_before_destroy = true 
    }

    depends_on = [
        aws_subnet.eks-lab-priv,
        aws_route_table.eks-lab-public-crt,
    ]
 }

