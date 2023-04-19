#!/usr/bin/env bash

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
        database_type: "postgresql"
        connection_string: "dbname=$PGDB user=$PGUSER password=$PGPW host=postgresql port=5432"
EOF

helm install postgresql postgresql --namespace "$scenario" --version 12.2.2 --repo https://charts.bitnami.com/bitnami -f /tmp/$$-db-values.yaml --wait

set -xe

SCRIPT=$(readlink -f "$0")
SCRIPTPATH=$(dirname "$SCRIPT")

helm install \
  --namespace "$scenario" \
  --values "${SCRIPTPATH}/../../../examples/production/values.yaml" \
  spire charts/spire -f /tmp/$$-spire-values.yaml --wait

helm test spire --namespace "$scenario"
