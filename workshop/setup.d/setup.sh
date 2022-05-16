#!/bin/bash

set -eo pipefail

KP_VERSION=0.5.0

# Install kp CLI
if [[ $(which kp) == "" ]]; then
  mkdir -p /home/eduk8s/bin
  curl --fail -L -o /home/eduk8s/bin/kp https://github.com/vmware-tanzu/kpack-cli/releases/download/v$KP_VERSION/kp-linux-$KP_VERSION && chmod 755 /home/eduk8s/bin/kp
fi

# This shouldn't be needed as being installed as package from workshop definition.
# The TCE_VERSION variable is set by the separate tce package so only need to
# set it here if that wasn't installed.

if [[ $(which tanzu) == "" ]]; then
  TCE_VERSION=0.12.0
  curl -L https://github.com/vmware-tanzu/community-edition/releases/download/v${TCE_VERSION}/tce-linux-amd64-v${TCE_VERSION}.tar.gz -o tce-linux-amd64-v${TCE_VERSION}.tar.gz
  tar -xf tce-linux-amd64-v${TCE_VERSION}.tar.gz
  mkdir -p /home/eduk8s/bin
  cd tce-linux-amd64-v${TCE_VERSION}
  cp tanzu /home/eduk8s/bin/tanzu
  ./install.sh
fi

# Install TCE package repository
tanzu package repository add tce-repo --url projects.registry.vmware.com/tce/main:$TCE_VERSION --namespace tanzu-package-repo-global

# Install Application Toolkit
envsubst < /opt/workshop/setup.d/app-toolkit-values-template.yaml > /opt/workshop/setup.d/app-toolkit-values.yaml
tanzu secret registry add registry-credentials --server $REGISTRY_HOST --username $REGISTRY_USERNAME --password $REGISTRY_PASSWORD --export-to-all-namespaces --yes
APP_TOOLKIT_VERSION=$(tanzu package available list app-toolkit.community.tanzu.vmware.com -o json | jq -r ".[].version" | sort -t "." -k1,1n -k2,2n -k3,3n | tail -n 1)
tanzu package install app-toolkit --package-name app-toolkit.community.tanzu.vmware.com --version $APP_TOOLKIT_VERSION -f /opt/workshop/setup.d/app-toolkit-values.yaml --namespace tanzu-package-repo-global

## Clone sample application to session git server
## (Can do this earlier in this script, in the background using a separate script)
#cd /opt/git/repositories
#git clone --bare https://github.com/ciberkleid/hello-go.git
#kp secret create git-credentials --git-url $GIT_PROTOCOL://$GIT_HOST --git-user $GIT_USERNAME || true
