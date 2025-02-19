output "eks_cluster_endpoint" {
  value = aws_eks_cluster.nextflix.endpoint
}

output "eks_cluster_certificate_authority" {
  value = aws_eks_cluster.nextflix.certificate_authority[0].data
}