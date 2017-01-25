# Vagrant learn-advanced-docker

Vagrant learn-advanced-docker creates ready-to-go [Docker] (https://www.docker.com/) VM.

The Vagrantfile creates a [Docker] (https://www.docker.com/) Machine with below components installed

+ **Docker Engine**
+ **Docker Compose**

Once Docker installed, it launch a [Graylog] (https://www.graylog.org/) instance. 
The docker daemon is configured to centralize its logs too this graylog.

Compose will build and run below containers:

+ **Graylog Server**
+ **MongoDB Database**
+ **Elasticsearch **

Once Docker launch it runs Docker Security Benchmark.

## Requirements

- [VirtualBox](https://www.virtualbox.org/wiki/Downloads). Tested on 5.1.0, but should also work on 5.0.20+ release.
- [Vagrant](http://www.vagrantup.com/downloads.html). Tested on 1.8.4

The VM is provisioned using addgene/trusty64 (Ubuntu 14.04 Trusty Tahr) from [atlas.hashicorp.com] (https://atlas.hashicorp.com/) images, thus your workstation must have a direct internet access. 

## VMs details

VM | vCPU/vRAM | IP Address| user/password | root / Administrator password |
---|---|---|---|---|
**docker** | 2vCPU/2048MB | 192.168.99.105 | vagrant/vagrant | vagrant |
+ **Recommended hardware :** Computer with Multi-core CPU and 8GB+ memory

## Installation

#### Getting started:

Run the commands below:

	git clone https://github.com/gilleslabs/learn-advanced-csa
	cd learn-csa


###### Launching CSA ready-to-go VM:

1. Run the command below:

	```
	vagrant up
	```

2. The setup will take some time to finish (approximatively 30 minutes depending on your hardware and Internet connection speed). Sit back and enjoy!

3. When the setup is done you can browse Graylog Server Console. 

##Graylog URL and credentials

Component | URL | user/password |
---|---|---|
Graylog | https://192.168.99.105:9000 | admin/admin |

In order to get docker daemon log configured on graylog please create a UDP GELF, following this [guide] (https://www.graylog.org/blog/28-centralized-docker-container-logging-with-native-graylog-integration) (note you can skip the docker stuff of this guide)

## Know issues


## Credits


## MIT

Copyright (c) 2016 Gilles Tosi

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE

