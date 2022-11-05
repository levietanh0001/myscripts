#!/bin/bash


# https://docs.docker.com/desktop/install/ubuntu/
# askubuntu.com/a/1411717/1645414

DOCKER_DESKTOP_PACKAGE=docker-desktop-4.13.0-amd64.deb

sudo apt-get update
sudo apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release -y
sudo mkdir -p /etc/apt/keyrings
sudo rm /etc/apt/keyrings/docker.gpg
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --batch --yes --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo chmod a+r /etc/apt/keyrings/docker.gpg
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

if [[ ! -f ~/Downloads/${DOCKER_DESKTOP_PACKAGE} ]] 
then
    echo 'docker desktop installation file not found'
    exit 1
else
    echo "${DOCKER_DESKTOP_PACKAGE} found"
fi

sudo dpkg -i ~/Downloads/${DOCKER_DESKTOP_PACKAGE}