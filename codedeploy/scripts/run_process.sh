#!/bin/bash

cd /home/ubuntu/scripts
sudo docker compose pull
sudo docker compose up -d --force-recreate
