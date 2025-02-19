provider "aws" {
  region = var.region
}

data "aws_iam_policy_document" "eks_cluster_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["eks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "eks_cluster" {
  name               = "nextflix-eks-cluster-role"
  assume_role_policy = data.aws_iam_policy_document.eks_cluster_assume_role.json
}

resource "aws_iam_role_policy_attachment" "eks_cluster_AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks_cluster.name
}

resource "aws_eks_cluster" "nextflix" {
  name     = "nextflix-eks-cluster"
  role_arn = aws_iam_role.eks_cluster.arn

  vpc_config {
    subnet_ids = var.public_subnets
  }

  tags = {
    Name = "nextflix-eks-cluster"
  }
}

data "aws_iam_policy_document" "eks_nodegroup_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "eks_nodegroup" {
  name               = "nextflix-eks-nodegroup-role"
  assume_role_policy = data.aws_iam_policy_document.eks_nodegroup_assume_role.json
}

resource "aws_eks_node_group" "nextflix" {
  cluster_name    = aws_eks_cluster.nextflix.name
  node_group_name = "nextflix-node-group"
  subnet_ids      = var.public_subnets
  node_role_arn   = aws_iam_role.eks_nodegroup.arn

  scaling_config {
    desired_size = 2
    max_size     = 4
    min_size     = 1
  }

  remote_access {
    ec2_ssh_key = var.key_pair_name
  }

  tags = {
    Name = "nextflix-node-group"
  }
}