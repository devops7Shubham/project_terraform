# Create EKS cluster
resource "aws_eks_cluster" "example" {
  name     = "example" # Name of the EKS cluster
  role_arn = aws_iam_role.eks_cluster_role.arn # Reference to the IAM role ARN
  

  vpc_config { # VPC configuration for the EKS cluster
    subnet_ids = var.subnet_ids#saws_subnet.example1.id, aws_subnet.example2.id] # IDs of the subnets where EKS instances will be deployed
    
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Cluster handling.
  # Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure such as Security Groups.
  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster_policy_attachment,
    aws_iam_role_policy_attachment.eks_vpc_policy_attachment,
  ]
}

# Create EKS node group
resource "aws_eks_node_group" "example" {
  cluster_name    = aws_eks_cluster.example.name # Name of the associated EKS cluster
  node_group_name = "example"                    # Name of the node group
  node_role_arn   = aws_iam_role.eks_node_role.arn # Reference to the IAM role ARN for the node group
  subnet_ids      = var.subnet_ids#aws_subnet.example1.id, aws_subnet.example2.id] # IDs of the subnets where EKS instances will be deployed
  

  scaling_config { # Scaling configuration for the node group
    desired_size = 1 # Number of desired instances
    max_size     = 2 # Maximum number of instances
    min_size     = 1 # Minimum number of instances
  }

  update_config { # Update configuration for the node group
    max_unavailable = 1 # Maximum number of unavailable instances during an update
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    aws_iam_role_policy_attachment.eks_node_policy_attachment,
    aws_iam_role_policy_attachment.eks_cni_policy_attachment,
    aws_iam_role_policy_attachment.eks_ecr_policy_attachment,
  ]
}
