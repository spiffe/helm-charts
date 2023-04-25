#!/usr/bin/env bash

set -xe

SCRIPT=$(readlink -f "$0")
SCRIPTPATH=$(dirname "$SCRIPT")

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

helm install mysql mysql --namespace "spire-server" --version "$VERSION_MYSQL" --repo "$HELM_REPO_MYSQL" \
  --values "${SCRIPTPATH}/mysql-values.yaml" \
  --values /tmp/$$-db-values.yaml --wait

helm install \
  --namespace "spire-server" \
  --values /tmp/$$-spire-values.yaml \
  --values "${SCRIPTPATH}/../../../examples/production/values.yaml" \
  spire charts/spire --wait

helm test spire --namespace "spire-server"
