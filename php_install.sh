#!/bin/bash

# https://cloudcone.com/docs/article/how-to-install-php-8-1-on-ubuntu-20-04-22-04/

sudo apt update
php -v
sudo apt install ca-certificates apt-transport-https software-properties-common
sudo add-apt-repository ppa:ondrej/php

## press ENTER

sudo apt update
sudo apt install php8.1 -y


## check ondrej added
# sudo grep -rhE ^deb /etc/apt/sources.list* | grep -i ondrej