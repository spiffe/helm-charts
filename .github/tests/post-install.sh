#!/usr/bin/env bash

set -x

SCRIPT="$(readlink -f "$0")"
SCRIPTPATH="$(dirname "${SCRIPT}")"
scenario="${scenario:-$(basename "${SCRIPTPATH}")}"

# shellcheck source=/dev/null
source "${SCRIPTPATH}/common.sh"

print_helm_releases
