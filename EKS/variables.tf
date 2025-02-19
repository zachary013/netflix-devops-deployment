variable "region" {
  description = "AWS Region"
  type        = string
}

variable "public_subnets" {
  description = "List of public subnet IDs"
  type        = list(string)
}

variable "key_pair_name" {
  description = "Name of the SSH key pair"
  type        = string
}