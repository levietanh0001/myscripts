#!/bin/bash

# https://www.cherryservers.com/blog/how-to-install-and-start-using-mariadb-on-ubuntu-20-04

MARIADB_VERSION=10.6
sudo apt update
sudo apt install mariadb-server mariadb-client -y
sudo apt install -y software-properties-common
sudo apt-key adv --fetch-keys 'https://mariadb.org/mariadb_release_signing_key.asc'
sudo add-apt-repository "deb [arch=amd64,arm64,ppc64el] https://mariadb.mirror.liquidtelecom.com/repo/${MARIADB_VERSION}/ubuntu focal main"
sudo apt update && sudo apt install -y mariadb-server mariadb-client

mariadb --version

sudo systemctl start mariadb
sudo systemctl enable mariadb
sudo systemctl status mariadb

## setup database
# sudo mysql_secure_installation
# sudo mariadb -u root -p
# CREATE USER 'levietanh'@'localhost' IDENTIFIED BY 'secret_password';
# GRANT ALL PRIVILEGES ON *.* TO 'levietanh'@'localhost';
# FLUSH PRIVILEGES;
# EXIT;

## create database and create user
# sudo mariadb -u levietanh -p
# CREATE DATABASE test_db;
# SHOW DATABASES;
# FLUSH PRIVILEGES
# SELECT host, user FROM mysql.user;

## configure mariadb
# sudo mariadb -u levietanh -p
# SELECT CEILING(Total_InnoDB_Bytes*1.6/POWER(1024,3)) RIBPS FROM
# (SELECT SUM(data_length+index_length) Total_InnoDB_Bytes
# FROM information_schema.tables WHERE engine='InnoDB') A;
# echo '/innodb_buffer_pool_size = 1G' | sudo tee /etc/mysql/my.cnf
# sudo systemctl restart mariadb
# sudo sysctl -w vm.swappiness=0 
# mysql> set global max_connections=500;
# echo 'skip-name-resolve' | sudo tee /etc/mysql/my.cnf
# echo 'query_cache_size=64M' | sudo tee /etc/mysql/my.cnf
# echo 'wait_timeout=60' | sudo tee /etc/mysql/my.cnf
# echo 'slow-query-log = 1' | sudo tee /etc/mysql/my.cnf
# echo 'slow-query-log-file = /var/lib/mysql/mysql-slow.log' | sudo tee /etc/mysql/my.cnf
# echo 'long_query_time = 1 ' | sudo tee /etc/mysql/my.cnf
