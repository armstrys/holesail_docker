# Easy Docker Tunnels
### Run a Docker container with a service and connect to it anywhere.

> **Warning:** This repository hosts your service through a public distributed hashtable. Connection and contents are protected by a cryptographic key, which you must safeguard. However, your IP address may be exposed. This is a side project, and I am not a security expert. Use at your own risk.

This repository simplifies pulling a Docker image of a self-hosted service and serving it across a [HyperDHT](https://docs.pears.com/building-blocks/hyperdht) P2P tunnel, avoiding many networking challenges associated with remote access.

## Getting Started (skip if you're familiar with Docker)
Docker allows you to pull prebuilt images and run them in isolated containers. While many server apps offer standalone Docker images, [holesail](https://holesail.io) simplifies connecting to these services from anywhere. You need [Docker](https://docs.docker.com) installed. On Mac, additional packages or usage of [OrbStack](https://orbstack.dev) will be needed.

The primary implementation uses [holesail](https://holesail.io), a newer version of [hypertele](https://github.com/bitfinexcom/hypertele). This repository will be updated as Holesail evolves, with a branch for those preferring hypertele and an MIT license.

## What Does This Repo Do?

You will need to perform a minimum of 3 steps:
1. run `bash build_holesail_service.sh`
2. place a compose.yml that defines your service (these are often provided by the service) in the folder created for you
3. run `bash start_service.sh`

Running `bash build_holesail_service.sh` in your Linux or Mac terminal will ask you to name the service, define the port the service will be running on, and then request or create a connector key for a secure connection.

After you provide your `compose.yml` file, `start_service.sh` will use that file along with the other files in the folder to run your service alongside a dedicated holesail connection.

Run `docker ps` to see running containers. To view logs and find your holesail key, use `docker logs holesailcontainer_name` on the holesail container. Your connection key is also accessible with quotation marks around it in the `.env` file for your service.

## Example

See in an example the `dozzle_example folder`. All the compose file was taken from [their website](https://dozzle.dev/guide/getting-started). The only modification was adding `restart: unless-stopped` to the `.yml` to allow the service to restart on its own. Dozzle is also a helpful tool to view your docker logs as you add more.

**TODO:**
- Create a script to launch a persistent Docker image on the client side.
- Develop a limited version using hypertele for MIT license compatibility.
