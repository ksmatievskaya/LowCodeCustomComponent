#!/bin/bash

export COMPOSE_DIR=${PWD}

echo "Generate PNG Topology ${COMPOSE_DIR}"

export MOUNT_POINT="${COMPOSE_DIR}/:/input"
echo "Mounting ${MOUNT_POINT}"

docker run --rm -it --name dcv -v $MOUNT_POINT pmsipilot/docker-compose-viz render -m image --force --output-file=docs/images/02-infra-topology.png docker-compose.yaml
