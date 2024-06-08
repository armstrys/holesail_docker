# Easy Docker Tunnels
### Run a Docker container with a service and connect to it anywhere.

> **Warning:** This repository hosts your service through a public distributed hashtable. Connection and contents are protected by a cryptographic key, which you must safeguard. However, your IP address may be exposed. This is a side project, and I am not a security expert. Use at your own risk.

This repository simplifies pulling a Docker image of a self-hosted service and serving it across a [HyperDHT](https://docs.pears.com/building-blocks/hyperdht) P2P tunnel, avoiding many networking challenges associated with remote access.

## Getting Started (skip if you're familiar with Docker)
Docker allows you to pull prebuilt images and run them in isolated containers. While many server apps offer standalone Docker images, [holesail](https://holesail.io) simplifies connecting to these services from anywhere. You need [Docker](https://docs.docker.com) installed. On Mac, additional packages or usage of [OrbStack](https://orbstack.dev) will be needed.

The primary implementation uses [holesail](https://holesail.io), a newer version of [hypertele](https://github.com/bitfinexcom/hypertele). This repository will be updated as Holesail evolves, with a branch for those preferring hypertele and an MIT license.

## What Does This Repo Do?
Running `bash holesail_service.sh` in your Linux or Mac terminal will:
1. Name your service for Docker and the definition folder.
2. Provide the Docker image tag to pull.
3. Specify the default port the service runs on.
4. Choose a different local port if needed.
5. Set a connection key (or generate a random one).

Run `docker ps` to see running containers. To view logs and find your holesail key, use `docker logs container_name` on the holesail container.

## Advanced Usage
The `holesail_services.sh` script creates a folder for service definitions and launches containers in the background with an auto-restart policy. Each service folder includes:

- `Dockerfile`: Custom Dockerfile to create a holesail-server image.
- `compose.yml`: Docker Compose file for holesail connection and service settings.
- `.env`: Environment variables for `config.yml`. You can manually edit this file.
- `start_service.sh`: Script to start services with Docker. `--build` ensures clean rebuilds, and `-d` runs containers in the background.

**TODO:**
- Create a script to launch a persistent Docker image on the client side.
- Develop a limited version using hypertele for MIT license compatibility.