#!/bin/bash

#set -eo pipefail
#
#KP_VERSION=0.5.0
#
#if [[ $(which kp) == "" ]]; then
#  # Install kp CLI
#  mkdir -p /home/eduk8s/bin
#  curl --fail -L -o /home/eduk8s/bin/kp https://github.com/vmware-tanzu/kpack-cli/releases/download/v$KP_VERSION/kp-linux-$KP_VERSION && chmod 755 /home/eduk8s/bin/kp
#fi
#
#kubectl create ns kpack
#kubectl create configmap kp-config -n kpack \
#        --from-literal="default.repository=$REGISTRY_HOST/kp"
#
## Run some commands in the background in parallel
#/opt/workshop/scripts/kpack-import-stack.sh &
#/opt/workshop/scripts/kpack-import-store.sh &
#/opt/workshop/scripts/git-clone-repositories.sh &
#
## Install TCE package repository
#tanzu package repository add tce-repo --url projects.registry.vmware.com/tce/main:$TCE_VERSION --namespace tanzu-package-repo-global
#
## Install Application Toolkit
#envsubst < /opt/workshop/setup.conf/app-toolkit-values-template.yaml > /opt/workshop/setup.conf/app-toolkit-values.yaml
#APP_TOOLKIT_VERSION=$(tanzu package available list app-toolkit.community.tanzu.vmware.com -o json | jq -r ".[].version" | sort -t "." -k1,1n -k2,2n -k3,3n | tail -n 1)
#tanzu package install app-toolkit --package-name app-toolkit.community.tanzu.vmware.com --version $APP_TOOLKIT_VERSION -f /opt/workshop/setup.conf/app-toolkit-values.yaml --namespace tanzu-package-repo-global
#
## Create example supply chain values file
#mkdir -p /opt/workshop/example
#echo "image_prefix=$REGISTRY_HOST" > /opt/workshop/example/values.yaml
#
## Set up kpack in the background (so the workshop UI can load now)
#/opt/workshop/scripts/kpack-create-builder.sh &
