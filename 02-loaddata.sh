#!/bin/bash

source .env.settings
source ${PGENVFILE}

docker run -it --rm -e PGPASSWORD=${POSTGRES_PASSWORD} --name guru-datamesh-prestore \
    --network="lowcode-data-mesh_default" -v $PWD/fixtures/:/dump  \
    postgres:15  /bin/sh -c \
    "cat /dump/create-db.init | psql -h datacluster -U superdba -d postgres"
