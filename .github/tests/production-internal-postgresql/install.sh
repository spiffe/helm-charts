#!/usr/bin/env bash

set -xe

SCRIPT=$(readlink -f "$0")
SCRIPTPATH=$(dirname "$SCRIPT")

DB=spire
DBUSER=spire
DBPW=$(uuidgen)
DBROOTPW=$(uuidgen)

cat <<EOF > /tmp/$$-spire-values.yaml
spire-server:
  postgresql:
    enabled: true
    auth:
      database: ${DB}
      username: ${DBUSER}
      password: ${DBPW}
      postgresPassword: ${DBROOTPW}
EOF

# FIXME
pushd charts/spire/charts/spire-server
helm dep up
popd

helm install \
  --namespace "spire-server" \
  --values /tmp/$$-spire-values.yaml \
  --values "${SCRIPTPATH}/../../../examples/production/values.yaml" \
  spire charts/spire --wait

helm test spire --namespace "spire-server"
