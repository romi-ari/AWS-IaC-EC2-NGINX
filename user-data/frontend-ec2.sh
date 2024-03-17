#!/bin/bash
sudo apt-get update
sudo apt-get install -y docker.io
sudo systemctl start docker
sudo docker pull romiari/todoapp:v1.0
sudo docker run -d -p 8090:8090 romiari/todoapp:v1.0