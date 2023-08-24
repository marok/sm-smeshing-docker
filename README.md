# Spacemesh Full Node Docker
[![Docker Image CI](https://github.com/marok/sm-smeshing-docker/actions/workflows/docker-image.yml/badge.svg)](https://github.com/marok/sm-smeshing-docker/actions/workflows/docker-image.yml)

## Usage

1. Prepare smeshing node working directory

        mkdir -p <SM_WORKDIR>/cfg
        mkdir -p <SM_WORKDIR>/log
        mkdir -p <SM_WORKDIR>/data
1. Prepare node specific config in ```<SM_WORKDIR>/cfg/node-config.json```. Example:

        {
          "smeshing": {
            "smeshing-opts": {
              "smeshing-opts-maxfilesize": 2147483648,
              "smeshing-opts-numunits": 4,
              "smeshing-opts-provider": 4294967295,
              "smeshing-opts-throttle": false,
              "smeshing-opts-compute-batch-size": 1048576
            },
            "smeshing-coinbase": "<YOUR_WALLET_ADDRESS>",
            "smeshing-proving-opts": {
              "smeshing-opts-proving-nonces": 288,
              "smeshing-opts-proving-threads": 3
            },
            "smeshing-start": true
          }
        }
    This JSON will be merged with Spacemesh mainnet configuration: https://smapp.spacemesh.network/config.mainnet.metrics.json. You can specify any valid option here - it will override the mainnet configuration.

1. Run docker. Docker compose example:

        # docker-compse.yaml

        version: '3.8'
        services:
          sm:
            image: ghcr.io/marok/spacemesh-node:latest
            container_name: sm
            network_mode: host
            restart: unless-stopped
            volumes:
              - <SM_WORKDIR>/data:/root/data
              - <SM_WORKDIR>/log:/root/log
              - <SM_WORKDIR>/cfg:/root/cfg
              - <sm post>:/root/post
            environment:
              - USER_NODE_CONFIG=/root/cfg/node-config.json
              - DATA_DIR=/root/data
              - POST_DIR=/root/post
              - LOG_DIR=/root/log
              - LISTEN_PORT=7513
            command:

    Run container via: ```docker compose pull && docker compose up -d```.

1. Verify in logs if Smacemesh full node is working:

        docker compose logs sm
