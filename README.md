# Templates for Easy Docker Tunnels
### Run a Docker container with a service and connect to it anywhere.

> **Warning:** This repository hosts your service through a public distributed hashtable. Connection and contents are protected by a cryptographic key, which you must safeguard. However, your IP address may be exposed. This is a side project, and I am not a security expert. Use at your own risk.

This repository simplifies using a Docker `compose.yml` of a self-hosted service and serving it across a [HyperDHT](https://docs.pears.com/building-blocks/hyperdht) P2P tunnel, avoiding many networking challenges associated with remote access.
- Run a holesail enabled service in Docker
- Run a holesail connected client in Docker

This repository provides two templates:
1. A docker template to launch a holesail server to expose a service outside your home network (and optionally run that service in docker)
2. A docker template to launch a holesail client to connect to the holesail server

You can make copies of these folders and edit them to add new services.

## Service template
1. To start cd into a copy of the `.service_template` folder
  - run `bash run_holesail_service.sh`
  - **or** simply fill out the `.env` file and run `docker compose up --build -d`
2. Optionally, add the docker compose.yml for a new service that you would like to run with holesail into the `compose.override.yml` file

Run `docker ps` to see running containers. To view logs and find your holesail key, use `docker logs holesail_container_name` on the holesail container. Your connection key is also accessible with quotation marks around it in the `.env` file for your service.

## Client template
To start cd into a copy of the `.client_template` folder
  - run `bash connect_client.sh`
  - **or** simply fill out the `.env` file and run `docker compose up --build -d`

As with the service containers, you can use `docker ps` and `docker logs container_name` to see container info including the address of your local service access

## Service Example
A good example to test is using Dozzle, which serves as a dashboard for your running docker containers. All the compose file was taken from [their website](https://dozzle.dev/guide/getting-started).

Setting the files below will allow you to launch this service and holesail with `docker compose up --build -d`. `bash run_holesail_service.sh` will interactively create the `.env` and start the services.

`.env`
```bash
DOCKER_NAME="dozzle"  # A unique name for your docker container
DOCKER_PORT=9999  # The port that will be used by your server - can be the same as the service port or different if needed
HOLESAIL_CONNECTOR="make_this_a_random_strong_password!!!!!!"
```

`compose.override.yml`
```yaml
version: "3"
services:
  dozzle:
    container_name: dozzle
    image: amir20/dozzle:latest
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
    ports:
      - 9999:8080
```

## Client Example
On another computer you can set up a dozzle client template by copying the `.template_client` folder and running `bash run_holesail_client.sh` or configuring the `.env` as seen below

`.env`
```bash
DOCKER_NAME="dozzle"  # A The name of the service you are connecting to
HOLESAIL_PORT=9999  # The port you want to use to find your service locally
HOLESAIL_CONNECTOR="this_should_match_the_key_in_your_service" # The connection string for your holesail connection (see your service)
```

You will now be able to access your service at `http://localhost:9999`


## Additional Resources
Docker allows you to pull prebuilt images and run them in isolated containers ([find some interesting ones here](https://github.com/petersem/dockerholics)). While many server apps offer standalone Docker images, [holesail](https://holesail.io) simplifies connecting to these services from anywhere. You need [Docker](https://docs.docker.com) installed. On Mac, additional packages or usage of [OrbStack](https://orbstack.dev) will be needed.

The primary implementation uses [holesail](https://holesail.io), a newer version of [hypertele](https://github.com/bitfinexcom/hypertele). This repository will be updated as Holesail evolves, with a branch for those preferring hypertele and an MIT license.

## Common Questions
- Why docker? Holesail is already really easy to use.
  - I am using Docker because it makes it easy to organize, launch, and maintain, services on a self-hosted machine. These templates are just a goal to add holesail into that mix to make it even easier

**TODO:**
- Develop a limited version using hypertele for MIT license compatibility.
