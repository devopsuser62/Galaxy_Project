#!/bin/bash

apt update -y

apt upgrade -y

apt install  wget -y

apt install curl -y

apt install mlocate -y  

apt install tree -y

apt install vim -y

#apt-add-repository ppa:ansible/ansible

apt update -y

apt install git -y

apt install python3

apt install ansible -y

useradd -m -s /bin/bash -G wheel jenkins

echo "%jenkins        ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers.d/no_passwd

echo "alias c=clear" >> /etc/profile

apt install python3-pip -y

alternatives --set python /usr/bin/python3

pip3 install boto3

pip3 install botocore

pip3 install awscli

ansible-galaxy collection install amazon.aws

apt remove docker docker-engine docker.io containerd runc -y

apt update -y

apt install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release -y

mkdir -m 0755 -p /etc/apt/keyrings

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

chmod a+r /etc/apt/keyrings/docker.gpg

apt update -y

apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
curl -LO "https://dl.k8s.io/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"
echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check > /dev/null
chmod +x ./kubectl
mv ./kubectl /usr/local/bin/kubectl
