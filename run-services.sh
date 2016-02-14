#!/bin/sh

/etc/init.d/ssh start

# /bin/bash

/srv/var/jmeter/apache-jmeter-2.13/bin/jmeter-server -Djava.rmi.server.hostname=127.0.0.1