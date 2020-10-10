data "aws_subnet_ids" "eks-lab-pub" {
  vpc_id = aws_vpc.eks-lab-vpc.id
}

data "aws_subnet" "eks-lab-pub" {
  for_each = data.aws_subnet_ids.eks-lab-pub.ids
  subnet_id = each.value
}

resource "aws_eks_cluster" "eks-lab" {
  name     = "eks-lab"
  role_arn = aws_iam_role.eks-lab-cluster-role.arn

  vpc_config {
    subnet_ids = data.aws_subnet.eks-lab-pub.subnet_id
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Cluster handling.
  # Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure such as Security Groups.
  depends_on = [
    aws_iam_role_policy_attachment.eks-lab-cluster-role-AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.eks-lab-cluster-role-AmazonEKSVPCResourceController,
  ]
}

output "endpoint" {
  value = aws_eks_cluster.eks-lab.endpoint
}

output "kubeconfig-certificate-authority-data" {
  value = aws_eks_cluster.eks-lab.certificate_authority[0].data
}