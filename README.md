# Easy Docker Tunnels
### Run a Docker container with a service and connect to it anywhere.

> **Warning:** This repository hosts your service through a public distributed hashtable. Connection and contents are protected by a cryptographic key, which you must safeguard. However, your IP address may be exposed. This is a side project, and I am not a security expert. Use at your own risk.

This repository simplifies pulling a Docker image of a self-hosted service and serving it across a [HyperDHT](https://docs.pears.com/building-blocks/hyperdht) P2P tunnel, avoiding many networking challenges associated with remote access.
- Run a holesail enabled service in Docker
- Run a holesail connected client in Docker

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

## Connecting

Once your connection is live you can connect with your connector key by running `holesail YOUR_CONNECTOR --port ANY_PORT --host localhost` and then access on that machine at `http://localhost:ANY_PORT`. Alternatively, you can copy your service folder to a new machine and launch a client docker container by running `bash connect_client.sh` from within the `client` folder.

## Example

A good example to test is using Dozzle, which serves as a dashboard for your running docker containers. All the compose file was taken from [their website](https://dozzle.dev/guide/getting-started).

Try creating a dozzle service with a port of 9999 and using a `compose.yml` with the following:

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

**TODO:**
- Create a script to launch a persistent Docker image on the client side.
- Develop a limited version using hypertele for MIT license compatibility.
