#!/bin/bash

## Author: <Peke> miikamoilanen@outlook.com 
## Script to install basic Docker CE and Docker-compose
## Meant for Debian bois
## Install dependencies 
## Docker

	echo "Docker CE not found, installing."
	apt -y install apt-transport-https ca-certificates curl gnupg2 software-properties-common	
	curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
	
	add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/debian \
   $(lsb_release -cs) \
   stable"
	
	apt update
	apt -y install docker-ce docker-ce-cli containerd.io
	systemctl enable docker.service
	systemctl start docker.service
	curl -L "https://github.com/docker/compose/releases/download/1.26.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
	chmod +x /usr/local/bin/docker-compose
	ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
	curl -L https://raw.githubusercontent.com/docker/compose/1.26.0/contrib/completion/bash/docker-compose -o /etc/bash_completion.d/docker-compose
