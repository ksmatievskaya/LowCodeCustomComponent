#!/bin/bash

source .env.dev

docker run -it --rm -e PGPASSWORD=${POSTGRES_PASSWORD} --name guru-datamesh-prestore \
    --network="guru-data-mesh_default" -v $PWD/fixtures/:/dump  \
    postgres:15  /bin/sh -c \
    "cat /dump/create-db.init | psql -h datacluster -U superdba -d postgres"
