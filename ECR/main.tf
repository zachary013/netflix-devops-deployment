provider "aws" {
  alias  = "us_east_1"
  region = "us-east-1"
}

resource "aws_ecrpublic_repository" "nextflix" {
  provider         = aws.us_east_1
  repository_name  = var.repository_name

  catalog_data {
    about_text        = "This repository contains Docker images for the Nextflix movie app"
    description       = "Nextflix Movies application container images"
    architectures     = ["ARM"]
    operating_systems = ["Linux"]
  }

  tags = {
    env = "production"
    app = "nextflix"
  }
}
