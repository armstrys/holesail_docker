#!/bin/bash
set -e
read -p "Please give the service a name you are connecting to: " service_name
read -p "What port do you want to use to find your service locally?: " docker_port
read -p "Please provide the holesail connection strin of your service: " connector

echo "# docker compose up --build -V" > .env
echo "DOCKER_NAME=\"${service_name}\"  # The name of the service you are connecting to" >> .env
echo "DOCKER_PORT=${docker_port}  # The port you want to use to find your service locally" >> .env
echo "HOLESAIL_CONNECTOR=\"${connector}\" # The connection string for your holesail connection (see your service)" >> .env

echo "Please place a compose.yml file for your service in th ${service_name} folder and then run \`bash start_service.sh from there\` "

# run client
docker compose up --build -d