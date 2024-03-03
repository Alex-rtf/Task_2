#######################################
# INSTALL DOCKER AND DOCKER COMPOSE EC2
#######################################

#!/bin/bash

# Update package lists
sudo apt-get update

# Install Docker
sudo apt-get install docker.io -y

# Start the Docker Service
sudo systemctl start docker

# Install Docker Compose
sudo apt-get install curl -y
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

# Apply executable permissions to the binary
sudo chmod +x /usr/local/bin/docker-compose
