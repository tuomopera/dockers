#!/bin/bash

## Author: <Peke> miikamoilanen@outlook.com 
## Script to install basic Docker CE and Docker-compose
## Meant for Debian bois
## Install dependencies 
## Docker


CHECK_DOCKER_VERSION=$(docker version | grep Version | cut -d':' -f 2 | awk '{print $1}' | sort -u | cut -d'.' -f 1)
CHECK_COMPOSE_VERSION=$(docker-compose version | grep docker-compose | awk '{print $3}' | tr ',' ' ' | cut -d'.' -f 1)

### Docker
if [[ $CHECK_DOCKER_VERSION -ge "0" ]]; then
##If version returns anything higher than 0 -- Docker present
	echo "Docker CE located, skipping install."
else 
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
fi

###Docker Compose
##If version returns anything higher than 0 -- Compose present
if [[ $COMPOSE_RESULT -ge "0" ]]; then
    echo "Docker Compose located, skipping install."
else
	curl -L "https://github.com/docker/compose/releases/download/1.26.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
	chmod +x /usr/local/bin/docker-compose
	ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
	curl -L https://raw.githubusercontent.com/docker/compose/1.26.0/contrib/completion/bash/docker-compose -o /etc/bash_completion.d/docker-compose
fi


### CS:GO files based on crazy-max/csgo-server-launcher/ - big thanks <3 
	read -p 'Install CS:GO Dedicated server? (Y/N): ' yesno
if [[ $yesno == *"y"* ]];then
	echo "Installing CSGO dedicated server"
	mkdir -p /etc/csgo/
	cp csgo-compose/* /etc/csgo
	echo "Installing CS:GO... Will take time, opening logs for you!"
	cd /etc/csgo	
	docker-compose up -d 
#	docker-compose logs -f
else
	echo "Bye"
fi
