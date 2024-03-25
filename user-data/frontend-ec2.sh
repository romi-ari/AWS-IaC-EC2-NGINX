#!/bin/bash
sudo apt-get update
sudo apt-get install -y docker.io nginx
sudo systemctl start docker nginx
sudo apt install -y certbot python3-certbot-nginx
sudo docker run -d -p 3000:3000 romiari/todoapp:v1.1