# Netflix-like App Infrastructure

A cloud infrastructure setup for deploying a Next.js frontend application using AWS services, Infrastructure as Code (IaC), and DevOps best practices.

## 🏗️ Architecture Overview

This project provisions a complete AWS infrastructure for hosting a Netflix-like streaming application frontend, using:

- **Amazon EKS (Elastic Kubernetes Service)** for container orchestration
- **Amazon ECR (Elastic Container Registry)** for Docker image storage
- **VPC** with public/private subnets for network isolation
- **Jenkins Server** for CI/CD pipeline management

## 🚀 Infrastructure Components

### VPC Configuration
- Custom VPC with dedicated CIDR block
- Public and private subnets across multiple availability zones
- Internet Gateway and NAT Gateway for secure outbound traffic
- Security groups and NACLs for network security

### EKS Cluster
- Managed Kubernetes control plane
- Worker nodes in private subnets
- Auto-scaling configuration
- RBAC and security policies

### Jenkins Server
- Dedicated EC2 instance for Jenkins
- Pipeline as Code configuration
- Integration with AWS services
- Automated deployment workflows

## 📋 Prerequisites

- AWS CLI configured with appropriate credentials
- Terraform >= 1.0.0
- kubectl installed
- Jenkins CLI (optional)

## 🛠️ Setup Instructions

1. Clone the repository:
```bash
git clone https://github.com/zachary013/netflix-devops-deployment.git
cd netflix-devops-deployment
```

2. Initialize Terraform:
```bash
terraform init
```

3. Review and modify variables in `variables.tf` as needed

4. Deploy the infrastructure:
```bash
terraform plan
terraform apply
```

## 📂 Project Structure

```
netflix-devops-deployment/
├── ECR/
│   ├── main.tf/
│   ├── outputs.tf
│   └── variables.tf/
├── EKS/
│   ├── main.tf/
│   ├── outputs.tf
│   └── variables.tf/
├── jenkins-server/
│   ├── main.tf/
│   ├── outputs.tf
│   └── variables.tf/
├── vpc-sg/
│   ├── main.tf
│   ├── outputs.tf
│   └── variables.tf
└── README.md
```

## 🔄 CI/CD Pipeline

The infrastructure supports a complete CI/CD workflow:
1. Code push triggers Jenkins pipeline
2. Application build and testing
3. Quality code with SonarQube
4. Docker image creation and push to ECR
5. Deployment to EKS cluster


## 🚨 Important Notes

- Remember to destroy resources when not in use
- Monitor AWS costs regularly
- Keep security groups and access rules updated
- Regularly update dependencies

