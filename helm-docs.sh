#!/usr/bin/env bash

set -euo pipefail

SCRIPTPATH=$(dirname "$0")
README_GENERATOR_VERSION="2.5.1"
README_GENERATOR_EXE="readme-generator"

if ! command -v -- "${README_GENERATOR_EXE}" > /dev/null 2>&1; then
  echo "readme-generator not installed. Installing..."
  if ! command -v -- "npm" > /dev/null 2>&1; then
    echo "npm is required to install ${README_GENERATOR_EXE}. Please install npm and rerun the script."
    exit 1
  fi
  # platform agnostic npm install, also adds into the path
  npm install -g "@bitnami/readme-generator-for-helm@${README_GENERATOR_VERSION}"
fi

# generate docs and show the diff
chart_paths=( $( find -type f -iname "Chart.yaml" | xargs -L1 dirname ) )
for cpath in "${chart_paths[@]}"
do
  echo "readme-generator --values=${cpath}/values.yaml --readme=${cpath}/README.md"
  readme-generator --values="${cpath}/values.yaml" --readme="${cpath}/README.md"
done
git diff --exit-code

