#!/bin/sh

SLEEP_TIME=4
MAX_TIME=60

set -e

echo "Started."
echo "MYSQL_USER: ${MYSQL_USER}"
echo "MYSQL_PASSWORD: ${MYSQL_PASSWORD}"
echo "MYSQL_PORT: ${MYSQL_PORT}"
echo "MYSQL_CLUSTER_NAME: ${MYSQL_CLUSTER_NAME}"
echo "MYSQL_CLUSTER_OPTIONS: ${MYSQL_CLUSTER_OPTIONS}"

cat > /tmp/create-cluster.js <<EOF
const mysqlUser = '${MYSQL_USER}';
const mysqlPassword = '${MYSQL_PASSWORD}';
const mysqlPort = '${MYSQL_PORT}';
const clusterName = '${MYSQL_CLUSTER_NAME}';
const clusterOptions = JSON.parse(${MYSQL_CLUSTER_OPTIONS});
const cluster = dba.createCluster(clusterName, clusterOptions);
cluster.addInstance({user: mysqlUser, password: mysqlPassword, host: 'server-2'});
cluster.addInstance({user: mysqlUser, password: mysqlPassword, host: 'server-3'});
EOF

echo "Attempting to create cluster."

until ( \
    mysqlsh \
        --user=${MYSQL_USER} \
        --password=${MYSQL_PASSWORD} \
        --host=server-1 \
        --port=${MYSQL_PORT} \
        --interactive \
        --file=/tmp/create-cluster.js \
)
do
    echo "Cluster creation failed."

    if [ $SECONDS -gt $MAX_TIME ]
    then
        echo "Maximum time of $MAX_TIME exceeded."
        echo "Exiting."
        exit 1
    fi

    echo "Sleeping for $SLEEP_TIME seconds."
    sleep $SLEEP_TIME
done

echo "Cluster created."
echo "Exiting."
