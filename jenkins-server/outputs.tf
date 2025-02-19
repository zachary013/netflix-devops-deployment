output "jenkins_instance_id" {
  value = aws_instance.nextflix_jenkins.id
}

output "jenkins_public_ip" {
  value = aws_instance.nextflix_jenkins.public_ip
}