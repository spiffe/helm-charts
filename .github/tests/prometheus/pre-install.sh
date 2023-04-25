#!/usr/bin/env bash

helm install kube-prometheus-stack kube-prometheus-stack --version $VERSION_KUBE_PROMETHEUS_STACK --repo $HELM_REPO_KUBE_PROMETHEUS_STACK -n "$scenario" --wait
