#!/usr/bin/env bash

set -euo pipefail

SCRIPTPATH=$(dirname "$0")
HELM_DOCS_VERSION="1.11.0"

case "$(uname -s)" in
  Linux*)
    machine=Linux
    shasum=sha256sum
    exe=helm-docs
    ;;
  Darwin*)
    machine=Darwin
    shasum=shasum
    exe=helm-docs
    ;;
  MINGW64*)
    machine=Windows
    shasum=sha256sum
    exe=helm-docs.exe
    ;;
esac

function install_helm_docs {
  curl -LO "https://github.com/norwoodj/helm-docs/releases/download/v${HELM_DOCS_VERSION}/helm-docs_${HELM_DOCS_VERSION}_${machine}_x86_64.tar.gz"
  curl -L --output /tmp/checksums_helm-docs.txt "https://github.com/norwoodj/helm-docs/releases/download/v${HELM_DOCS_VERSION}/checksums.txt"
  grep "helm-docs_${HELM_DOCS_VERSION}_${machine}_x86_64.tar.gz" /tmp/checksums_helm-docs.txt | $shasum -c -
  mkdir -p "$SCRIPTPATH/bin"
  tar -xf "helm-docs_${HELM_DOCS_VERSION}_${machine}_x86_64.tar.gz" "${exe}"
  mv "${exe}" "$SCRIPTPATH/bin/"
  rm "helm-docs_${HELM_DOCS_VERSION}_${machine}_x86_64.tar.gz"
}

if [ ! -f "$SCRIPTPATH/bin/${exe}" ] ; then
  install_helm_docs
elif [[ ! "$("$SCRIPTPATH/bin/${exe}" --version)" =~ .*"$HELM_DOCS_VERSION".* ]] ; then
  install_helm_docs
else
  echo "Using '$("$SCRIPTPATH/bin/${exe}" --version)'"
fi

# validate docs
"$SCRIPTPATH/bin/${exe}" --document-dependency-values
git diff --exit-code
