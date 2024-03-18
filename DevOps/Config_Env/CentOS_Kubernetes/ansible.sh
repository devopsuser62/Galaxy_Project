#!/bin/bash

usermod -aG wheel jenkins

echo "%jenkins        ALL=(ALL)       NOPASSWD: ALL"  >> /etc/sudoers.d/no_passwd

echo "192.168.211.138    Kubernetes-Master"  >> /etc/hosts

echo "192.168.211.139    Kubernetes-Worker"  >> /etc/hosts

echo "192.168.211.136    NFS-Server"  >> /etc/hosts

echo "192.168.211.132    Jenkins-Slave"  >> /etc/hosts

echo "192.168.211.133    Jenkins-Master"  >> /etc/hosts
