# Easy docker tunnels
### Run a docker container with a service and connect to it easily ***anywhere***.

> Warning: This repo will host your service through a public distributed hashtable. The ability to connect to your service and its contents will be protected by a cryptographic key that you need to protect on your own, but your IP address (and port??? I don't know...) may be exposed on the protocol. This is a fun side project for me and I am not a security expert or a cryptographer. Use at your own risk!

This is a git repo to make it dead simple to pull the docker image of a self-hosted service and serve it across a [HyperDHT](https://docs.pears.com/building-blocks/hyperdht) P2P tunnel that avoids many of the networking challenges associated with accessing self-hosted services remotely.

The primary implementation is using [holesail](https://holesail.io) which is a newer implementation of [hypertele](https://github.com/bitfinexcom/hypertele). I will attempt to update this repo as Holesail continues to add features, but plan to have a branch (or possibly another repo) availably using hypertele for those who want minimal features, but need an MIT license for their usage.

Make a random private connector with
```bash
echo "HOLESAIL_CONNECTOR=\"$(head -c 63 /dev/random | base64)\"" >> .env
```

A .env file is provided in this repo that defines an example below that runs a dockerized service ([traggo](https://traggo.net)) and then serves it via holesail - the key used to connect on a remote machine will be output in the terminal or docker logs. Run the example with:


```bash
docker compose up --build -V
```

Alternatively, you can define a service on the fly like

```bash
DOCKER_IMAGE=traggo/server:latest SERVICE_PORT=3030 docker compose up --build -V
```

Connect on a remote machine with:

```bash
holesail {your_seed}
```

or if you would like to access on a certain port, besides the default of 8989

```bash
holesail {your_seed} --port {a_new_port}
```

You can now access your connection at http://127.0.0.1:8989 or the same address with 8989 replaced by your selected port.

TODO:
 - allow input of custom string as a seed (password)
 - allow host parameter to vary
 - make a limited version using hypertele for uses where MIT license is needed