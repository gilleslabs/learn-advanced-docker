# Vagrant learn-csa

Vagrant learn-csa creates ready-to-go [HP Cloud Service Automation Community Edition 4.6.0] (http://www8.hp.com/fr/fr/software-solutions/cloud-service-automation/) VM.

The Vagrantfile creates a [Docker] (https://www.docker.com/) Machine with below components installed

+ **Docker Engine**
+ **Docker Compose**

Once Docker installed, it Compose HP Cloud Service Automation based on HP Software [CSA Docker image] (https://hub.docker.com/r/hpsoftware/csa/) .

Compose will build and run below containers:

+ **HP Cloud Service Automation Management Console**
+ **HP Cloud Service Automation Market Place Portal**
+ **HP Operations Orchestration Central**

## Requirements

- [VirtualBox](https://www.virtualbox.org/wiki/Downloads). Tested on 5.0.20, but should also work on 5.0.20+ release.
- [Vagrant](http://www.vagrantup.com/downloads.html). Tested on 1.7.4

The VM is provisioned using ubuntu/trusty64 (Ubuntu 14.04 Trusty Tahr) from [atlas.hashicorp.com] (https://atlas.hashicorp.com/ubuntu/boxes/trusty64) images, thus your workstation must have a direct internet access. 

## VMs details

VM | vCPU/vRAM | IP Address| user/password | root / Administrator password |
---|---|---|---|---|
**csa** | 4vCPU/4096MB | 192.168.99.10 | vagrant/vagrant | vagrant |
+ **Recommended hardware :** Computer with Multi-core CPU and 8GB+ memory

## Installation

#### Getting started:

Run the commands below:

	git clone https://github.com/gilleslabs/learn-csa
	cd learn-csa


###### Launching CSA ready-to-go VM:

1. Run the command below:

	```
	vagrant up
	```

2. The setup will take some time to finish (approximatively 30 minutes depending on your hardware and Internet connection speed). Sit back and enjoy!

3. When the setup is done you can browse HP Cloud Service Automation Management Console,HP Cloud Service Automation Market Place Portal or HP Operations Orchestration Central. 

##HP Cloud Service Automation URL and credentials

Component | URL | user/password |
---|---|---|
CSA Management Console | https://192.168.99.10:18444/csa | admin/cloud |
CSA MarketPlace Portal | https://192.168.99.10:18089/mpp | consumer/cloud |
Operations Orchestration Central | https://192.168.99.10:18445/oo | admin/cloud |


## Know issues


## Credits

This project was totally inspired from [HPE Cloud Service Automation Community Edition 4.6 (HPE CSA CE) in Docker](https://github.com/HewlettPackard/csa-ce)


## MIT

Copyright (c) 2016 Gilles Tosi

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE
# learn-advanced-docker
