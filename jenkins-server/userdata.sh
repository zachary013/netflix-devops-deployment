#!/bin/bash

# Update package lists
sudo apt-get update
sudo apt-get upgrade -y

# Install Docker
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker ubuntu

# Install dependencies for Jenkins
echo "Installing dependencies for Jenkins..."
sudo apt-get install -y fontconfig openjdk-17-jre wget gnupg software-properties-common unzip

# Add Jenkins GPG key and repository
echo "Adding Jenkins GPG key and repository..."
sudo wget -qO /usr/share/keyrings/jenkins-keyring.asc https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

sudo apt-get update -y
echo "Installing Jenkins..."
sudo apt-get install -y jenkins
sudo systemctl start jenkins
sudo systemctl enable jenkins

# Install kubectl
curl -O https://s3.us-west-2.amazonaws.com/amazon-eks/1.31.2/2024-11-15/bin/linux/amd64/kubectl
curl -O https://s3.us-west-2.amazonaws.com/amazon-eks/1.31.2/2024-11-15/bin/linux/amd64/kubectl.sha256
sha256sum -c kubectl.sha256
chmod +x ./kubectl
mkdir -p $HOME/bin && cp ./kubectl $HOME/bin/kubectl && export PATH=$HOME/bin:$PATH

# Install AWS CLI
curl -o "awscliv2.zip" "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip"
unzip -q awscliv2.zip
sudo ./aws/install
rm -f awscliv2.zip
rm -rf aws

# Install Trivy (container image scanner)
curl -sfL https://raw.githubusercontent.com/aquasecurity/trivy/main/contrib/install.sh | sh -s -- -b /usr/local/bin

# Start SonarQube using Docker
docker run -d --name sonar -p 9000:9000 sonarqube:lts-community

# Restart Jenkins to apply changes
sudo systemctl restart jenkins

# Output completion message
echo "Jenkins server setup completed successfully!"