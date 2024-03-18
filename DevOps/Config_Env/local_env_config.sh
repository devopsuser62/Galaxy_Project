#!/bin/bash

if [[ "$(whoami)" == "root" ]]; then

usermod -aG wheel jenkins

hostnamectl set-hostname jenkins-master

echo "%jenkins        ALL=(ALL)       NOPASSWD: ALL"  >> /etc/sudoers.d/sudo_group

echo "alias c=clear" >> /etc/profile

source /etc/profile

dnf install -y mlocate yum-utils epel-release

mandb && updatedb

ip addr show | grep 'inet ' | awk '{print $2}' | cut -d'/' -f1 | sed -n '2p' > ip_extract

echo "`cat ip_extract`    `hostname`"  >> /etc/hosts

#echo "192.168.211.145    Jenkins-Worker"  >> /etc/hosts

#echo "192.168.211.136    NFS-Server"  >> /etc/hosts

#echo "192.168.211.132    Jenkins-Slave"  >> /etc/hosts

#echo "192.168.211.133    Jenkins-Master"  >> /etc/hosts

else
    echo "You must be root to perform this script."
fi
