#!/bin/bash

# Set random root password (if not preset via docker envrionment ROOT_PASSWORD
ROOT_PASSWORD=${ROOT_PASSWORD:-$(pwgen -s -1 16)}
echo "root password is: $ROOT_PASSWORD"
echo root:$ROOT_PASSWORD | chpasswd

# Install ssh key to login as root
echo "Setting SSH-KEY: $SSH"
echo $SSH > /root/.ssh/authorized_keys

# start sshd
/usr/sbin/sshd

# start jmeter
/srv/var/jmeter/apache-jmeter-2.13/bin/jmeter-server -Djava.rmi.server.hostname=127.0.0.1