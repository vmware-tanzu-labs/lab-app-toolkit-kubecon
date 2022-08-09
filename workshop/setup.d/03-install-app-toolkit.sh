#!/bin/bash

set -eo pipefail
set -x

# Install App Toolkit and wait for main controllers to deploy.

envsubst < /opt/workshop/setup.d/app-toolkit-values-template.yaml > /opt/workshop/setup.d/app-toolkit-values.yaml

tanzu secret registry add registry-credentials --server $REGISTRY_HOST --username $REGISTRY_USERNAME --password $REGISTRY_PASSWORD --export-to-all-namespaces --yes

APP_TOOLKIT_VERSION=$(tanzu package available list app-toolkit.community.tanzu.vmware.com -o json | jq -r ".[].version" | sort -t "." -k1,1n -k2,2n -k3,3n | tail -n 1)

tanzu package install app-toolkit --package-name app-toolkit.community.tanzu.vmware.com --version $APP_TOOLKIT_VERSION -f /opt/workshop/setup.d/app-toolkit-values.yaml --namespace tanzu-package-repo-global

STATUS=1
ATTEMPTS=0
ROLLOUT_STATUS_CMD="kubectl rollout status deployment/controller -n knative-serving"

until [ $STATUS -eq 0 ] || $ROLLOUT_STATUS_CMD || [ $ATTEMPTS -eq 12 ]; do
    sleep 5
    $ROLLOUT_STATUS_CMD
    STATUS=$?
    ATTEMPTS=$((ATTEMPTS + 1))
done

STATUS=1
ATTEMPTS=0
ROLLOUT_STATUS_CMD="kubectl rollout status deployment/cartographer-controller -n cartographer-system"

until [ $STATUS -eq 0 ] || $ROLLOUT_STATUS_CMD || [ $ATTEMPTS -eq 12 ]; do
    sleep 5
    $ROLLOUT_STATUS_CMD
    STATUS=$?
    ATTEMPTS=$((ATTEMPTS + 1))
done
