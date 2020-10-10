resource "aws_eks_node_group" "eks-lab" {
  cluster_name    = aws_eks_cluster.eks-lab.name
  node_group_name = "eks-lab"
  node_role_arn   = aws_iam_role.eks-lab.arn
  subnet_ids = ["subnet-00f83ae395e8d08b7", "subnet-02dbb4925d946527c", "subnet-03684fda8a5f53fc3", "subnet-08e9f477a9a73d4e1", "subnet-0d2eb1d50e8dbf1ea", "subnet-0de75af25c0b0be24"]

  scaling_config {
    desired_size = 1
    max_size     = 3
    min_size     = 1
  }

  # Optional: Allow external changes without Terraform plan difference
  lifecycle {
    ignore_changes = [scaling_config[0].desired_size]
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    aws_iam_role_policy_attachment.eks-lab-node-group-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.eks-lab-node-group-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.eks-lab-node-group-AmazonEC2ContainerRegistryReadOnly,
  ]
}