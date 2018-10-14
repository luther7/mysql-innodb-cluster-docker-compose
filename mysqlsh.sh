#!/bin/sh

set -e

source ./.env

docker-compose \
    exec \
    server-1 \
    mysqlsh \
    --user=${MYSQL_USER} \
    --password=${MYSQL_PASSWORD} \
    "$@"
