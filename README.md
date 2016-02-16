# Docker JMeter 2.13 with plugins 1.3.1 for server/remote use (and communication via ssh tunnel)

## Contains

* JMeter 2.13
* JMeterPlugins-Standard 1.3.1
* JMeterPlugins-Extras 1.3.1
* JMeterPlugins-ExtrasLibs 1.3.1
* user.properties


## Run server

  `docker run --rm -p 60000:22 -ti -e SSH="<public SSH key for login>" devtransition/jmeter-remote-sshd`

## Run local jmeter controller

### Configuration

Add these value to your local jmeter.properties file:

  `remote_hosts=127.0.0.1:55501`
  
  `client.rmi.localport=55512`
  
  `server.rmi.localport=60000`
  

### Start

  `ssh -L 55501:127.0.0.1:55501 -L 55511:127.0.0.1:55511 -R 55512:127.0.0.1:55512 -p 60000 root@<remote ip>

  `jmeter -Djava.rmi.server.hostname=127.0.0.1`


### Build
  `git clone https://github.com/devtransition/docker-jmeter-server-sshd`

  `make build`