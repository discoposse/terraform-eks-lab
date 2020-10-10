resource "aws_eks_cluster" "eks-lab" {
  name     = "eks-lab"
  role_arn = aws_iam_role.eks-lab.arn

  vpc_config {
    subnet_ids = ["subnet-00f83ae395e8d08b7", "subnet-02dbb4925d946527c", "subnet-03684fda8a5f53fc3", "subnet-08e9f477a9a73d4e1", "subnet-0d2eb1d50e8dbf1ea", "subnet-0de75af25c0b0be24"]
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Cluster handling.
  # Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure such as Security Groups.
  depends_on = [
    aws_iam_role_policy_attachment.eks-lab-AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.eks-lab-AmazonEKSVPCResourceController,
  ]
}

output "endpoint" {
  value = aws_eks_cluster.eks-lab.endpoint
}

output "kubeconfig-certificate-authority-data" {
  value = aws_eks_cluster.eks-lab.certificate_authority[0].data
}