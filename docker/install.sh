#!/usr/bin/env bash

sudo apt-get update

# Install docker
cd /home/pi
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo usermod -aG docker ${USER}
docker version
# Install docker-compose
sudo apt-get install -y libffi-dev libssl-dev
sudo apt install -y python3-dev python3 python3-pip
sudo pip3 install docker-compose