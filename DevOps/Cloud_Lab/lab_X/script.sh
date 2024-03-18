#!/bin/bash

sudo yum update -y

sudo yum install  wget -y

sudo yum install curl -y

sudo yum install mlocate -y 

sudo yum install tree -y

sudo yum install vim  -y

sudo yum install -y python3-pip

sudo yum install yum-utils -yi

sudo yum install epel-release -y

sudo yum install ansible -y

pip3 install boto3

pip3 install botocore

ansible-galaxy collection install amazon.aws

pip3 install awscli --upgrade --user

aws --version

sudo yum remove docker docker-ce docker-client docker-client-latest docker-common docker-latest docker-latest-logrotate docker-logrotate  docker-engine -y

sudo yum-config-manager  --add-repo https://download.docker.com/linux/centos/docker-ce.repo

sudo yum install docker-ce -y

sudo yum install firewalld -y

sudo yum install git -y

useradd -m -s /bin/bash -G wheel jenkins

echo "%jenkins        ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers.d/no_passwd

echo "alias c=clear" >> /etc/profile

sudo yum module remove container-tools -y

sudo yum install docker -y

curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
curl -LO "https://dl.k8s.io/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"
echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check > /dev/null
chmod +x ./kubectl
mv ./kubectl /usr/local/bin/kubeclt
