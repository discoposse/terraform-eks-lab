data "aws_subnet_ids" "eks-lab-pub-list" {
  vpc_id = aws_vpc.eks-lab-vpc.id
}

data "aws_subnet" "eks-lab-pub-list" {
  for_each = data.aws_subnet_ids.eks-lab-pub-list.ids
  subnet_id = each.value
}

resource "aws_eks_node_group" "eks-lab" {
  cluster_name    = aws_eks_cluster.eks-lab.name
  node_group_name = "eks-lab"
  node_role_arn   = aws_iam_role.eks-lab-node-group.arn
  subnet_ids = data.aws_subnet.eks-lab-pub-list.subnet_id

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