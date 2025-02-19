output "jenkins_instance_id" {
  description = "Jenkins EC2 Instance ID"
  value       = aws_instance.nextflix_jenkins.id
}

output "jenkins_public_ip" {
  description = "Public IP of Jenkins server"
  value       = aws_instance.nextflix_jenkins.public_ip
}
