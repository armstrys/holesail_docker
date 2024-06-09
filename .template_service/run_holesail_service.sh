#!/bin/bash
set -e
read -p "Please give the service a name (no spaces, A-Z, 0-9 and _ only): " service_name
read -p "What port is your service using?: " docker_port
read -p "Please provide a holesail connection string [63 char random hex]: " connector
read -p "What is the local address of the computer hosting the service? [localhost]: " host

name=${docker_port:=$service_port}  # if empty default to service_port
connector=${connector:=$(head -c 63 /dev/random | base64)}  # if empty defaul to random hex
host=${host:="localhost"}  # if empty defaul "localhost"

echo "# docker compose up --build -V" > .env
echo "DOCKER_NAME=\"${service_name}\"  # A unique name for your docker container" >> .env
echo "DOCKER_PORT=${docker_port}  # The port that will be used by your server - can be the same as the service port or different if needed" >> .env
echo "HOLESAIL_CONNECTOR=\"${connector}\"" >> .env
echo "SERVICE_HOST=\"${host}\"" >> .env

docker compose up --build -d
