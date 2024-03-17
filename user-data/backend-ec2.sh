#!/bin/bash
sudo apt-get update
sudo apt-get install -y docker.io
sudo systemctl start docker
sudo docker pull romiari/todoapp-api:v1.0
sudo docker run -d -p 3000:3000 romiari/todoapp-api:v1.0