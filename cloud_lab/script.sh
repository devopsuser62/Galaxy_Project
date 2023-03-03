#!/bin/bash

dnf update -y

dnf install  wget -y

dnf install curl -y

dnf install mlocate -y 

dnf install tree -y

dnf install vim  -y

dnf install epel-release -y 

dnf install ansible -y

dnf install git -y

useradd -m -s /bin/bash -G wheel jenkins

echo "%jenkins        ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers.d/no_passwd

echo "alias c=clear" >> /etc/profile

dnf install -y python3-pip

alternatives --set python /usr/bin/python3

pip3 install boto3

pip3 install botocore

pip3 install awscli

ansible-galaxy collection install amazon.aws

sudo yum module remove container-tools

sudo yum-config-manager  --add-repo https://download.docker.com/linux/centos/docker-ce.repo

sudo yum install docker-ce -y

curl -LO https://dl.k8s.io/release/v1.26.1/bin/linux/arm64/kubectl
curl -LO https://dl.k8s.io/v1.26.1/bin/linux/arm64/kubectl.sha256
echo 4027cb0a2840bc14ec3f18151b3360dd2d1f6ce730ed5ac28bd846c17e7d73f5 kubectl | sha256sum --check
chmod +x ./kubectl
mv ./kubectl /usr/local/bin/kubectl
