provider "aws" {
  region = var.region
}

resource "aws_ecr_repository" "nextflix" {
  name                 = "nextflix"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    env = "production"
    app = "nextflix"
  }
}