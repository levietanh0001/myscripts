#!/bin/bash

# PPA: latest version
sudo apt-get install curl 
curl -sL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt install nodejs
node -v

# LTS: long term support
# sudo apt-get install curl 
# curl -sL https://deb.nodesource.com/setup_16.x | sudo -E bash - 