output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnets" {
  value = [for s in aws_subnet.public : s.id]
}

output "default_security_group_id" {
  value = aws_vpc.main.default_security_group_id
}