# Easy docker tunnels
### Run a docker container with a service and connect to it easily ***anywhere***.

> Warning: This repo will host your service through a public distributed hashtable. The ability to connect to your service and its contents will be protected by a cryptographic key that you need to protect on your own, but your IP address (and port??? I don't know...) may be exposed on the protocol. This is a fun side project for me and I am not a security expert or a cryptographer. Use at your own risk!

This is a git repo to make it dead simple to pull the docker image of a self-hosted service and serve it across a [HyperDHT](https://docs.pears.com/building-blocks/hyperdht) P2P tunnel that avoids many of the networking challenges associated with accessing self-hosted services remotely.

## The Basics (skip this if you are comfortable with Docker)
Docker allows you to pull prebuilt images from the internet and run them in isolated "containers". Many server apps offer a standalone Docker image that will allow you to deploy an app on your local server, but after that you are on your own. This is where [holesail](https://holesail.io) comes in! The code in this repo will allow you to launch a companion docker container for each service that gives you a connection to that service that you can tunnel into from anywhere. You will need an installation of [Docker](https://docs.docker.com) for this repo to be useful. On Mac you will need additional packages or you can try [OrbStack](https://orbstack.dev), which is a drop in replacement for Docker on Mac.

The primary implementation is using [holesail](https://holesail.io) which is a newer implementation of [hypertele](https://github.com/bitfinexcom/hypertele). I will attempt to update this repo as Holesail continues to add features, but plan to have a branch (or possibly another repo) available using hypertele for those who want minimal features, but need an MIT license for their usage.

## What does this repo actually do?
When you run the `bash holesail_service.sh` in your linux or mac terminal you will be prompted for information to make a few things happen:
1. give your service a name that can be used in docker and for the definition folder
2. provide the tag of the docker image you will want to pull. You can find many examples on the internet - I have not tested many yet and some may require more configuration than this repository allows. You can always attempt to manually edit the configuration for a given service and run `bash start_service.sh` to rerun a particular service.
3. Asks you to proved the default port that the service runs on. This should be provided in the documentation for the service you are installing.
4. Allows you to select a different port for your local server (This is mostly important if you want to run two instances of things that want to use the same port).
5. Asks for a connection key (this is effectively your password). If you do not select one then it will generate a random 63 character key. You will need to check the logs of the holesail container to get this key after it starts!

You can run `docker_ps` to see your running containers.

To view the logs of a container (including your holesail key), run `docker logs container_name` on the holesail container for the appropriate service

## Digging deeper (for debugging or further customization)
Running the `holesail_services.sh` script will build a folder to define the services and attempt to launch the containers in the background with a docker policy to always restart unless stopped

Each service folder consists of 4 files (3 of which get copied from the `.template_service` folder):
- `Dockerfile` - a custom Dockerfile to make a holesail-server image
- `compose.yml` - a Docker Compose settings file that will define the holesail connection and your service settings. Some more complex services may require you to put additional settings in the compose.yml. This is a hierarchical settings file and you will mainly want to tinker with adding arguments or additional settings to the non-holesail service. You can often find examples in the service documentation if it is an official Docker image from the team
- `.env` - a settings file that provides environment variables to the `config.yml`. The `holesail_services.sh` script builds a rough version of this file for you. You can always manually edit or add some additional variables for service settings if you see fit.
- `start_service.sh` - a very simple script that defines how the services are started using docker. `--build -V` ensures a clean rebuild of the images each time in case there are updates. `-d` tells the containers to run in the background so that they are not shutdown when this terminal instance closes.


TODO:
 - build an equivalent script to launch a persistent docker image on the client side for accessing these services
 - make a limited version using hypertele for uses where MIT license is needed