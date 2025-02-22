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
git clone https://github.com/your-username/netflix-devops-deployment.git
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
│   ├── terraform/
│   ├── main.tf
│   └── variables.tf
├── EKS/
│   ├── terraform/
│   └── kubernetes-manifests/
├── jenkins-server/
│   ├── terraform/
│   └── pipeline-configs/
├── vpc-sg/
│   └── terraform/
└── README.md
```

## 🔄 CI/CD Pipeline

The infrastructure supports a complete CI/CD workflow:
1. Code push triggers Jenkins pipeline
2. Application build and testing
3. Docker image creation and push to ECR
4. Deployment to EKS cluster
5. Health checks and rollback capability

## 🔐 Security Considerations

- All sensitive data managed through AWS Secrets Manager
- Network isolation through VPC design
- Least privilege access principles
- Regular security patches through automated updates
- Infrastructure encryption at rest and in transit

## 🧰 Maintenance

- Regular `terraform plan` to check for drift
- Monitor EKS cluster health
- Review Jenkins pipeline logs
- Backup critical configurations
- Keep Terraform modules updated

## 📝 Contributing

1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

## 🚨 Important Notes

- Remember to destroy resources when not in use
- Monitor AWS costs regularly
- Keep security groups and access rules updated
- Regularly update dependencies

## 📬 Support

For issues and feature requests, please create an issue in the repository.

## 📜 License

[Add your license information here]