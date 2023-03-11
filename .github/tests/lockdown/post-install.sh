#!/bin/bash
if [ $1 -ne 0 ]; then
  echo '==> Events of namespace spire-server'
  echo '........................................................................................................................'
  echo '>>> kubectl --request-timeout=30s get events --output wide --namespace spire-server'
  kubectl --request-timeout=30s get events --output wide --namespace spire-server
  echo '........................................................................................................................'
  echo '<== Events of namespace spire-server'
  echo '........................................................................................................................'
  echo '>>> kubectl --request-timeout=30s describe pods --namespace spire-server'
  kubectl --request-timeout=30s describe pods --namespace spire-server
  echo '========================================================================================================================'

  echo '==> Events of namespace spire-system'
  echo '........................................................................................................................'
  echo '>>> kubectl --request-timeout=30s get events --output wide --namespace spire-system'
  kubectl --request-timeout=30s get events --output wide --namespace spire-system
  echo '........................................................................................................................'
  echo '<== Events of namespace spire-system'
  echo '........................................................................................................................'
  echo '>>> kubectl --request-timeout=30s describe pods --namespace spire-system'
  kubectl --request-timeout=30s describe pods --namespace spire-system
  echo '========================================================================================================================'
  kubectl get pods -o name -n spire-server | while read line; do echo logs for $line; kubectl logs -n spire-server $line --all-containers=true --ignore-errors=true; done
  kubectl get pods -o name -n spire-system | while read line; do echo logs for $line; kubectl logs -n spire-system $line --all-containers=true --ignore-errors=true; done
  echo '========================================================================================================================'
fi
