#!/bin/bash
set -e
read -p "Please give the service a name (no spaces, A-Z, 0-9 and _ only): " service_name

mkdir ${service_name}
cp -r ./.template_service/* ./${service_name}

read -p "Please provide the tag of the docker service you want to run: " service_tag

# make sure the tag can be pulled
docker pull $service_tag

read -p "What is the default port used by the service (refer to service docs): " service_port
read -p "What port should your local server use? [${service_port}]: " docker_port
read -p "Please provide a holesail connection string [63 char random hex]: " connector

name=${docker_port:=$service_port}  # if empty default to service_port
connector=${connector:=$(head -c 63 /dev/random | base64)}  # if empty defaul to random hex

echo "# docker compose up --build -V" > ./${service_name}/.env
echo "DOCKER_NAME=\"${service_name}\"  # A unique name for your docker container" >> ./${service_name}/.env
echo "DOCKER_IMAGE=\"${service_tag}\"  # The name of a docker image that you want to run" >> ./${service_name}/.env
echo "SERVICE_PORT=${service_port}  # The default port used by the service - see the docs to see how you access the service" >> ./${service_name}/.env
echo "DOCKER_PORT=${docker_port}  # The port that will be used by your server - can be the same as the service port or different if needed" >> ./${service_name}/.env
echo "HOLESAIL_CONNECTOR=\"${connector}\"" >> ./${service_name}/.env

cd ${service_name}
bash ./start_service.sh