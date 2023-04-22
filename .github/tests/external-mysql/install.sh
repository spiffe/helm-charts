#!/usr/bin/env bash

set -xe

DB=spire
DBUSER=spire
DBPW=$(uuidgen)
DBROOTPW=$(uuidgen)

# Generate random settings to make sure things come up with random settings.
cat > /tmp/$$-db-values.yaml <<EOF
auth:
  database: ${DB}
  username: ${DBUSER}
  password: ${DBPW}
  rootPassword: ${DBROOTPW}
EOF

cat > /tmp/$$-spire-values.yaml <<EOF
spire-server:
  dataStore:
    sql:
      plugin_data:
        database_type: "mysql"
        connection_string: "${DBUSER}:${DBPW}@tcp(mysql:3306)/${DB}?parseTime=true"
EOF

helm install mysql mysql --namespace "$scenario" --version 9.7.2 --repo https://charts.bitnami.com/bitnami -f /tmp/$$-db-values.yaml --wait

helm install \
  --namespace "$scenario" \
  spire charts/spire -f /tmp/$$-spire-values.yaml --wait

helm test spire --namespace "$scenario"
