#!/bin/sh

######################################################################################################
#                                                                                                    #
#      Setup of $docker variable which will be used for docker VM Shell inline provisioning          #
#                                                                                                    #
######################################################################################################


echo "Build start at    :" > /tmp/build
date >> /tmp/build 

###### Update our cache #####
sudo apt-get update -y

##### Auditing ######
sudo apt-get install auditd -y

##### Adding some stuff for LVM #####

sudo apt-get install thin-provisioning-tools -y

###############     Installing Docker            ###################

sudo apt-get install apt-transport-https ca-certificates -y
sudo apt-key adv --keyserver --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
sudo touch /etc/apt/sources.list.d/docker.list
sudo rm /etc/apt/sources.list.d/docker.list
sudo echo deb https://apt.dockerproject.org/repo ubuntu-trusty main > /etc/apt/sources.list.d/docker.list
sudo apt-get update -y
sudo apt-get purge lxc-docker
sudo apt-cache policy docker-engine
sudo apt-get upgrade -y
sudo apt-get install linux-image-extra-$(uname -r) -y


##### Option : install specific version of docker - run apt-cache madison docker-engine to see which version are available ####
# sudo apt-get install docker-engine=1.12.3-0~trusty -y --force-yes

##### Comment below line if you uncomment previous one #####

sudo apt-get install docker-engine -y --force-yes
sudo service docker start
sudo groupadd docker
sudo usermod -aG docker vagrant

################     Installing Docker-Compose            ###################
################     This will install docker-compose     ###################

sudo apt-get -y install python-pip
sudo pip install docker-compose

################     Updating host and ufw                ###################
	

sudo ufw --force enable

####### According to docker documentation we should force DEFAULT_FORWARD_POLICY to ACCEPT - However DROP should be OK for realease > 1.10 ######
sudo sed -i 's|DEFAULT_FORWARD_POLICY="DROP"|DEFAULT_FORWARD_POLICY="ACCEPT"|g' /etc/default/ufw
sudo ufw --force reload

######### Enabling ssh access to the VM #######
sudo ufw allow 22/tcp

######### Allowing access to docker daemon ####
sudo ufw allow 2375/tcp

######### Optional allowing access to daemon using TLS##### 
sudo ufw allow 2376/tcp

###### Catching IP address of eth1 will be used to bind docker daemon to this IP ##### 
ip=$(ifconfig eth1 | grep 'inet addr:' | cut -d: -f2 | awk '{ print $1}')

#### Make docker listening on unix socket and eth1 - Enabling devicemapper instead of aufs (dependencies with Virtualbox image) -Enabling logging to Graylog #####
sudo echo DOCKER_OPTS=\"-D --log-driver=gelf --log-opt gelf-address=udp://$ip:12201 --storage-driver=devicemapper --tls=false -H unix:///var/run/docker.sock -H tcp://$ip:2375\" >> /etc/default/docker
sudo service docker restart


##### Activating auditing ######
sudo echo "
## Docker
-i
-w /etc/default/docker -k docker
-w /etc/docker -k docker
-w /etc/sysconfig/docker -k docker
-w /etc/sysconfig/docker-network -k docker
-w /etc/sysconfig/docker-registry -k docker
-w /etc/sysconfig/docker-storage -k docker
-w /etc/systemd/system/docker-registry.service -k docker
-w /etc/systemd/system/docker.service -k docker
-w /lib/systemd/system/docker-registry.service -k docker
-w /lib/systemd/system/docker.service -k docker
-w /lib/systemd/system/docker.socket -k docker
-w /usr/bin/docker-containerd-ctr -k docker
-w /usr/bin/docker-containerd -k docker
-w /usr/bin/docker-containerd-shim -k docker
-w /usr/bin/docker -k docker
-w /usr/bin/docker-runc -k docker
-w /usr/lib/systemd/system/docker-registry.service -k docker
-w /usr/lib/systemd/system/docker.service -k docker
-w /var/lib/docker -k docker
-w /var/run/docker.sock -k docker" | tee /etc/audit/audit.rules

sudo service auditd restart

##### Enabling Central logging in Graylog #######

sudo -u vagrant echo "
version: '2'
services:
  some-mongo:
    image: \"mongo:3\"
  some-elasticsearch:
    image: \"elasticsearch:2\"
    command: \"elasticsearch -Des.cluster.name='graylog'\"
  graylog:
    image: graylog2/server:2.1.1-1
    environment:
      GRAYLOG_PASSWORD_SECRET: somepasswordpepper
      GRAYLOG_ROOT_PASSWORD_SHA2: 8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918
      GRAYLOG_WEB_ENDPOINT_URI: http://192.168.99.105:9000/api
    links:
      - some-mongo:mongo
      - some-elasticsearch:elasticsearch
    ports:
      - \"9000:9000\"
      - \"12201/udp:12201/udp\"
      - \"1514/udp:1514/udp\"" | tee docker-compose.yml

##### Launching Graylog ######
docker-compose up -d

###### Running docker CIS Benchmark against our installation ###########

docker run --net host --pid host --cap-add audit_control \
    -e DOCKER_CONTENT_TRUST=$DOCKER_CONTENT_TRUST \
    -v /var/lib:/var/lib \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v /usr/lib/systemd:/usr/lib/systemd \
    -v /etc:/etc --label docker_bench_security \
    docker/docker-bench-security


echo "Build completed at      :" >> /tmp/build
date >> /tmp/build
cat /tmp/build
echo
