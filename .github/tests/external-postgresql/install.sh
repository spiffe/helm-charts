#!/usr/bin/env bash

set -xe

DB=$(uuidgen)
DBUSER=$(uuidgen)
DBPW=$(uuidgen)
DBPGPW=$(uuidgen)

# Generate random settings to make sure things come up with random settings.
cat > /tmp/$$-db-values.yaml <<EOF
auth:
  database: ${DB}
  username: ${DBUSER}
  password: ${DBPW}
  postgresPassword: ${DBPGPW}
EOF

cat > /tmp/$$-spire-values.yaml <<EOF
spire-server:
  dataStore:
    sql:
      plugin_data:
        database_type: "postgres"
        connection_string: "dbname=${DB} user=${DBUSER} password=${DBPW} host=postgresql port=5432 sslmode=disable"
EOF

helm install postgresql postgresql --namespace "$scenario" --version 12.2.2 --repo https://charts.bitnami.com/bitnami -f /tmp/$$-db-values.yaml --wait

helm install \
  --namespace "$scenario" \
  spire charts/spire -f /tmp/$$-spire-values.yaml --wait

helm test spire --namespace "$scenario"
