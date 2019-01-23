#!/bin/bash

## Author: <Peke> miikamoilanen@outlook.com 
## Script to install basic Docker CE and Docker-compose
## Meant for RPM based installations
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
	yum install -y yum-utils device-mapper-persistent-data lvm2
	yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
	yum install docker-ce
	systemctl enable docker.service
	systemctl start docker.service
fi

###Docker Compose
##If version returns anything higher than 0 -- Compose present
if [[ $COMPOSE_RESULT -ge "0" ]]; then
        echo "Docker Compose located, skipping install."
else
	yum install epel-release
	yum install -y python-pip
	pip install docker-compose
	yum upgrade python*
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
