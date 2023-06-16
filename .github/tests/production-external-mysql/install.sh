#!/usr/bin/env bash

set -xe

SCRIPT=$(readlink -f "$0")
SCRIPTPATH=$(dirname "$SCRIPT")

DB=spire
DBUSER=spire
DBPW=$(uuidgen)
DBROOTPW=$(uuidgen)

# Generate random settings to make sure things come up with random settings.
cat <<EOF > /tmp/$$-db-values.yaml
auth:
  database: ${DB}
  username: ${DBUSER}
  password: ${DBPW}
  rootPassword: ${DBROOTPW}
EOF

cat <<EOF > /tmp/$$-spire-values.yaml
spire-server:
  dataStore:
    sql:
      databaseType: mysql
      databaseName: ${DB}
      username: ${DBUSER}
      password: ${DBPW}
      host: mysql
      port: 3306
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
