#!/usr/bin/env bash

set -euo pipefail

SCRIPTPATH=$(dirname "$0")
README_GENERATOR_VERSION="2.5.1"
README_GENERATOR_EXE="readme-generator"

if ! hash "${README_GENERATOR_EXE}" 2>/dev/null; then
  echo "readme-generator not installed. Installing..."
  hash npm 2>/dev/null || { echo >&2 "npm is required to install ${README_GENERATOR_EXE}. Please install npm and rerun the script. Aborting."; exit 1; }
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

