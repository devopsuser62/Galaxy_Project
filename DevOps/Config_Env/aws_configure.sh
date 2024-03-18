#!/bin/bash

sudo dnf install -y python3-pip

pip3 install boto3

pip3 install botocore

ansible-galaxy collection install amazon.aws

pip3 install awscli --upgrade --user

aws --version
