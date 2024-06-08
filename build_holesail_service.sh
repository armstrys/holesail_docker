#!/bin/bash
set -e
read -p "Please give the service a name (no spaces, A-Z, 0-9 and _ only): " service_name

mkdir ${service_name}
cp -r ./.template_service/* ./${service_name}

read -p "What port is your service using?: " docker_port
read -p "Please provide a holesail connection string [63 char random hex]: " connector

name=${docker_port:=$service_port}  # if empty default to service_port
connector=${connector:=$(head -c 63 /dev/random | base64)}  # if empty defaul to random hex

echo "# docker compose up --build -V" > ./${service_name}/.env
echo "DOCKER_NAME=\"${service_name}\"  # A unique name for your docker container" >> ./${service_name}/.env
echo "DOCKER_PORT=${docker_port}  # The port that will be used by your server - can be the same as the service port or different if needed" >> ./${service_name}/.env
echo "HOLESAIL_CONNECTOR=\"${connector}\"" >> ./${service_name}/.env

echo "Please place a compose.yml file for your service in th ${service_name} folder and then run \`bash start_service.sh from there\` "