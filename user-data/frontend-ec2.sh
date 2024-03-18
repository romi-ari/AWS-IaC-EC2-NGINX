#!/bin/bash
sudo apt-get update
sudo apt-get install -y docker.io
sudo systemctl start docker
sudo docker run -d -p 3000:3000 romiari/todoapp:v1.1