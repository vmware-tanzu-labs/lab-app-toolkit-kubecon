#!/bin/bash

set -eo pipefail

KP_VERSION=0.5.0

# Install kp CLI
if [[ $(which kp) == "" ]]; then
  mkdir -p /home/eduk8s/bin
  curl --fail -L -o /home/eduk8s/bin/kp https://github.com/vmware-tanzu/kpack-cli/releases/download/v$KP_VERSION/kp-linux-$KP_VERSION && chmod 755 /home/eduk8s/bin/kp
fi

# Clone repositories
/opt/workshop/scripts/git-clone-repositories.sh &

# Install TCE package repository
tanzu package repository add tce-repo --url projects.registry.vmware.com/tce/main:$TCE_VERSION --namespace tanzu-package-repo-global

# Install Application Toolkit
envsubst < /opt/workshop/setup.conf/app-toolkit-values-template.yaml > /opt/workshop/setup.conf/app-toolkit-values.yaml
tanzu secret registry add registry-credentials --server $REGISTRY_HOST --username $REGISTRY_USERNAME --password $REGISTRY_PASSWORD --export-to-all-namespaces --yes
APP_TOOLKIT_VERSION=$(tanzu package available list app-toolkit.community.tanzu.vmware.com -o json | jq -r ".[].version" | sort -t "." -k1,1n -k2,2n -k3,3n | tail -n 1)
tanzu package install app-toolkit --package-name app-toolkit.community.tanzu.vmware.com --version $APP_TOOLKIT_VERSION -f /opt/workshop/setup.conf/app-toolkit-values.yaml --namespace tanzu-package-repo-global

kp secret create git-credentials --git-url $GIT_PROTOCOL://$GIT_HOST --git-user $GIT_USERNAME || true

# Run scripts in the background (so the workshop UI can load now)
#/opt/workshop/scripts/kpack-create-builder.sh &
#/opt/workshop/scripts/carto-create-supply-chain.sh &
