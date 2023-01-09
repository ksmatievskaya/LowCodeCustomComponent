#!/bin/bash

source .env.settings
source ${PGENVFILE}

docker run -it --rm -e PGPASSWORD=${POSTGRES_PASSWORD} --name guru-public-mesh-pgdump \
    --network="lowcode-data-mesh_default" \
    postgres:15  pg_dump -h datacluster -U superdba streams > ./fixtures/db/streams.examples.backup


docker run -it --rm -e PGPASSWORD=${POSTGRES_PASSWORD} --name guru-public-mesh-pgdump \
    --network="lowcode-data-mesh_default" \
    postgres:15  pg_dump -h datacluster -U superdba strategy > ./fixtures/db/strategy.examples.backup

curl -d'{"type": "export_metadata", "args": {}}' http://localhost:8080/v1/metadata -o fixtures/hasura_metadata.json
