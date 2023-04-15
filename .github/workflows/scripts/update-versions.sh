#!/bin/bash

SCRIPT=$(readlink -f "$0")
SCRIPTPATH=$(dirname "$SCRIPT")

CHARTJSON=$SCRIPTPATH/../../tests/charts.json

jq -r ".[].name" $CHARTJSON | while read CHART; do
  ENTRYQUERY='.[] | select(.name == "'$CHART'")'
  REPO_URL="$(jq -r "$ENTRYQUERY | .repo" $CHARTJSON)"
  VERSION="$(jq -r "$ENTRYQUERY | .version" $CHARTJSON)"
  echo Processing: $CHART
  echo "  repo: $REPO_URL"
  echo "  ver: $VERSION"
  helm repo add "$CHART" "$REPO_URL"
  helm repo update "$CHART"
  NEW_VERSION=$(helm search repo --regexp "$CHART/$CHART\v" -o json | jq -r '.[0].version')
  echo $VERSION $NEW_VERSION
  if [ "x$VERSION" != "x$NEW_VERSION" ]; then
    echo New version found.
    jq "( $ENTRYQUERY ).version |= "'"'$NEW_VERSION'"' $CHARTJSON > /tmp/$$
    mv /tmp/$$ $CHARTJSON
  fi
done
