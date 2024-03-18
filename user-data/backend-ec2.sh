#!/bin/bash
sudo apt-get update
sudo apt-get install -y docker.io postgresql-client-14
sudo systemctl start docker
sudo docker run -d -p 8090:8090 romiari/todoapp-api:v2.0