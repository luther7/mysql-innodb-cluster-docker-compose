#!/bin/sh

set -e

source ./.env

docker-compose \
    exec \
    server-1 \
    mysql \
    --user=${MYSQL_USER} \
    --password=${MYSQL_PASSWORD} \
    --host=router \
    --port=6446 \
    "$@"

