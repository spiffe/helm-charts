#!/usr/bin/env bash

set -xe

PGDB=$(uuidgen)
PGUSER=$(uuidgen)
PGPW=$(uuidgen)
PGPGPW=$(uuidgen)

# Generate random settings to make sure things come up with random settings.
cat > /tmp/$$-db-values.yaml <<EOF
global:
  postgresql:
    auth:
      database: $PGDB
      username: $PGUSER
      password: $PGPW
      postgresPassword: $PGPGPW
EOF

cat > /tmp/$$-spire-values.yaml <<EOF
spire-server:
  dataStore:
    sql:
      plugin_data:
        database_type: "postgres"
        connection_string: "dbname=$PGDB user=$PGUSER password=$PGPW host=postgresql port=5432 sslmode=disable"
EOF

helm install postgresql postgresql --namespace "$scenario" --version 12.2.2 --repo https://charts.bitnami.com/bitnami -f /tmp/$$-db-values.yaml --wait

helm install \
  --namespace "$scenario" \
  spire charts/spire -f /tmp/$$-spire-values.yaml --wait

helm test spire --namespace "$scenario"
