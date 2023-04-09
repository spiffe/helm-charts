#!/usr/bin/env bash

helm install kube-prometheus-stack kube-prometheus-stack --version 45.7.1 --repo https://prometheus-community.github.io/helm-charts -n "$scenario" --wait
