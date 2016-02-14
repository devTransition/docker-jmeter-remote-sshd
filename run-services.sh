#!/bin/bash

# Set random root password (if not preset via docker envrionment ROOT_PASSWORD
ROOT_PASSWORD=${ROOT_PASSWORD:-$(pwgen -s -1 16)}
echo "root password is: $ROOT_PASSWORD"
echo root:$ROOT_PASSWORD | chpasswd

# Install ssh key to login as root
echo "Setting SSH-KEY: $SSH"
echo $SSH > /root/.ssh/authorized_keys

# "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDLUvjbH5c3NM71QwP4IL3f7srp7cB0/vBisiw8nWmRDA3r2ALrIcS55eS2cnATmOU39pBV2M2eK24utqS3NQtqy1mXdJ5ebhgJhh/yZqqVY84EBi889ZNS2zc1hG3vuHwY90xH5PxBdngUOdoFLAe8hYG8/24d1rG+Oa+G0W6LWgQHnS9V+x6Tjqs7CN9CUEoB4u+Q1BORmS9hFt26O6cJbAgi5hqC4m7EBRCKEgkzVLKC+W/3Cka6vUdHoPeJP8is+Nwq3F+YAGqQOPSmGhCRdST9FKYSI7Wz1H1350sK9TYh1UYZ0vKUglC51OcSpaWGE+warkq0OFehoNxQIw1d .ssh/orceo_nwild_rsaa.key"

# start sshd
/usr/sbin/sshd

# start jmeter
/srv/var/jmeter/apache-jmeter-2.13/bin/jmeter-server -Djava.rmi.server.hostname=127.0.0.1