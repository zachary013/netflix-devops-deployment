output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnet_ids" {
  value = aws_subnet.public[*].id
}

output "jenkins_sg_id" {
  description = "ID of the Jenkins security group"
  value       = aws_security_group.jenkins_sg.id
}