# Define IAM role for EKS cluster
resource "aws_iam_role" "eks_cluster_role" {
  name               = "eks-cluster-role" # Name of the IAM role
  assume_role_policy = jsonencode({        # Define the trust policy allowing EKS service to assume this role
    Version   = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Principal = {
        Service = "eks.amazonaws.com"
      }
      Action    = "sts:AssumeRole"
    }]
  })
}
# Attach policies to the IAM role for EKS cluster
resource "aws_iam_role_policy_attachment" "eks_cluster_policy_attachment" {
  role       = aws_iam_role.eks_cluster_role.name # Reference to the IAM role
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy" # ARN of the policy granting required permissions for EKS cluster
}

resource "aws_iam_role_policy_attachment" "eks_vpc_policy_attachment" {
  role       = aws_iam_role.eks_cluster_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController" # ARN of the policy granting VPC-related permissions for EKS cluster
}

# Define IAM role for EKS node group
resource "aws_iam_role" "eks_node_role" {
  name               = "eks-node-role" # Name of the IAM role
  assume_role_policy = jsonencode({      # Define the trust policy allowing EC2 service to assume this role
    Version   = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
      Action    = "sts:AssumeRole"
    }]
  })
}

# Attach policies to the IAM role for EKS node group
resource "aws_iam_role_policy_attachment" "eks_node_policy_attachment" {
  role       = aws_iam_role.eks_node_role.name # Reference to the IAM role
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy" # ARN of the policy granting required permissions for EKS node group
}

resource "aws_iam_role_policy_attachment" "eks_cni_policy_attachment" {
  role       = aws_iam_role.eks_node_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy" # ARN of the policy granting CNI-related permissions for EKS node group
}

resource "aws_iam_role_policy_attachment" "eks_ecr_policy_attachment" {
  role       = aws_iam_role.eks_node_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly" # ARN of the policy granting read-only access to ECR for EKS node group
}
