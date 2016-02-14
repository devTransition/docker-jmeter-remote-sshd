# A image with apache-jmeter-2.12
# For more information; https://github.com/rdpanek/docker_jmeter

FROM rdpanek/base
MAINTAINER Radim Daniel Pánek <rdpanek@gmail.com>

# env
ENV JMETER_VERSION 2.13
ENV PLUGINS_VERSION 1.2.0
ENV JMETER_PATH /srv/var/jmeter
ENV PLUGINS_PATH $JMETER_PATH/plugins

# Install SSH
RUN apt-get install -y --force-yes openssh-server
RUN mkdir /var/run/sshd
RUN mkdir /root/.ssh
# Install ssh key to login as root
RUN echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDLUvjbH5c3NM71QwP4IL3f7srp7cB0/vBisiw8nWmRDA3r2ALrIcS55eS2cnATmOU39pBV2M2eK24utqS3NQtqy1mXdJ5ebhgJhh/yZqqVY84EBi889ZNS2zc1hG3vuHwY90xH5PxBdngUOdoFLAe8hYG8/24d1rG+Oa+G0W6LWgQHnS9V+x6Tjqs7CN9CUEoB4u+Q1BORmS9hFt26O6cJbAgi5hqC4m7EBRCKEgkzVLKC+W/3Cka6vUdHoPeJP8is+Nwq3F+YAGqQOPSmGhCRdST9FKYSI7Wz1H1350sK9TYh1UYZ0vKUglC51OcSpaWGE+warkq0OFehoNxQIw1d .ssh/orceo_nwild_rsaa.key" > /root/.ssh/authorized_keys

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

RUN echo 'root:jmeter' | chpasswd

RUN sed -i -e 's/without-password/yes/g' /etc/ssh/sshd_config

# Automagically accept Oracle's license (for oracle-java8-installer)
RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections

# Install Jmeter
RUN add-apt-repository ppa:webupd8team/java
RUN apt-get update
RUN apt-get install -y --force-yes oracle-java8-installer
RUN apt-get install -y --force-yes unzip

RUN mkdir -p $JMETER_PATH && cd $JMETER_PATH && \
    wget http://www.eu.apache.org/dist//jmeter/binaries/apache-jmeter-$JMETER_VERSION.tgz && \
    tar -zxf apache-jmeter-$JMETER_VERSION.tgz && \
    rm apache-jmeter-$JMETER_VERSION.tgz

# Install dependencies
# - JMeterPlugins-Standard 1.2.0
# - JMeterPlugins-Extras 1.2.0
# - JMeterPlugins-ExtrasLibs 1.2.0

# Install JMeterPlugins-ExtrasLibs
RUN mkdir -p $PLUGINS_PATH && \
    wget -q http://jmeter-plugins.org/downloads/file/JMeterPlugins-ExtrasLibs-$PLUGINS_VERSION.zip && \
    unzip -o -d $PLUGINS_PATH JMeterPlugins-ExtrasLibs-$PLUGINS_VERSION.zip && \
    wget -q http://jmeter-plugins.org/downloads/file/JMeterPlugins-Extras-$PLUGINS_VERSION.zip && \
    unzip -o -d $PLUGINS_PATH JMeterPlugins-Extras-$PLUGINS_VERSION.zip && \
    wget -q http://jmeter-plugins.org/downloads/file/JMeterPlugins-Standard-$PLUGINS_VERSION.zip && \
    unzip -o -d $PLUGINS_PATH JMeterPlugins-Standard-$PLUGINS_VERSION.zip

# Copy plugins to jmeter enviroment
RUN cp $PLUGINS_PATH/lib/*.jar $JMETER_PATH/apache-jmeter-$JMETER_VERSION/lib/
RUN cp $PLUGINS_PATH/lib/ext/*.jar $JMETER_PATH/apache-jmeter-$JMETER_VERSION/lib/ext/

# Copy user.properties
ADD user.properties $JMETER_PATH/apache-jmeter-$JMETER_VERSION/bin/

ADD run-services.sh /
RUN chmod a+x /run-services.sh

EXPOSE 22
CMD /run-services.sh

# /srv/var/jmeter/apache-jmeter-2.13/bin/jmeter-server"]