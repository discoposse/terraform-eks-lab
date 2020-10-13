resource "aws_security_group" "ssh-allowed" {
    vpc_id = aws_vpc.eks-lab-vpc.id
    name = "eks-lab-allow-ssh-http-https"
    
    egress {
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = var.allowed_ip_network
    }

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = var.allowed_ip_network
    }

    ingress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = var.allowed_ip_network
    }

    tags = {
        Name = "eks-lab-allow-ssh-http-https"
        Terraform = "true"
        Turbonomic = "true"
    }
}