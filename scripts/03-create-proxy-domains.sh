#!/bin/bash

source ./.env.settings

echo "create proxy for domain *.${DOMAINPREFIX}"

python scripts/prepare/proxy-service.py -d "${DOMAINPREFIX}" -u "${PROXYSUPERUSER}" -s ${PROXYSUPERPASS}
