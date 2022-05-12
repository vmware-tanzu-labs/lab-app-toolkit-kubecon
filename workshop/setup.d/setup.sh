#!/bin/bash

set -eo pipefail

# Run some commands in parallel
/opt/workshop/scripts/clone-git-repositories.sh &

# Install TCE package repository
tanzu package repository add tce-repo --url projects.registry.vmware.com/tce/main:$TCE_VERSION --namespace tanzu-package-repo-global

# Install Application Toolkit
envsubst < /opt/workshop/setup.d/app-toolkit-values-template.yaml > /opt/workshop/setup.d/app-toolkit-values.yaml
APP_TOOLKIT_VERSION=$(tanzu package available list app-toolkit.community.tanzu.vmware.com -o json | jq -r ".[].version" | sort -t "." -k1,1n -k2,2n -k3,3n | tail -n 1)
tanzu package install app-toolkit --package-name app-toolkit.community.tanzu.vmware.com --version $APP_TOOLKIT_VERSION -f /opt/workshop/setup.d/app-toolkit-values.yaml --namespace tanzu-package-repo-global

# Set up kpack in the background (so the workshop UI can load now)
/opt/workshop/scripts/setup-kpack-resources.sh &
