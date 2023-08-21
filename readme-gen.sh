#!/usr/bin/env bash

set -euo pipefail

SCRIPTPATH=$(dirname "$0")
README_GENERATOR_VERSION="2.5.1"
README_GENERATOR_EXE="readme-generator"

# platform agnostic npm install, also adds into the path
npm install -g "@bitnami/readme-generator-for-helm@${README_GENERATOR_VERSION}"

if [[ -z '$(type -d "${README_GENERATOR_EXE}")' ]]; then
  echo "readme-generator not installed successfully!!"
fi

# generate docs and show the diff
readme-generator --values="${SCRIPTPATH}/charts/spire/values.yaml" --readme="${SCRIPTPATH}/charts/spire/README.md"
git diff --exit-code

