#!/usr/bin/env bash

set -xe

SCRIPT=$(readlink -f "$0")
SCRIPTPATH=$(dirname "$SCRIPT")

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

helm install postgresql postgresql --namespace "spire-server" --version "$VERSION_POSTGRESQL" --repo "$HELM_REPO_POSTGRESQL" \
  --values "${SCRIPTPATH}/postgresql-values.yaml" \
  --values /tmp/$$-db-values.yaml --wait

helm install \
  --namespace "spire-server" \
  --values /tmp/$$-spire-values.yaml \
  --values "${SCRIPTPATH}/../../../examples/production/values.yaml" \
  spire charts/spire --wait

helm test spire --namespace "spire-server"
