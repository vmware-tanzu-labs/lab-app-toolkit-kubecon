#!/bin/bash

set -x

# Install kp CLI
mkdir -p /home/eduk8s/bin
KP_VERSION=0.5.0
curl --fail -L -o /home/eduk8s/bin/kp https://github.com/vmware-tanzu/kpack-cli/releases/download/v$KP_VERSION/kp-linux-$KP_VERSION && chmod 755 /home/eduk8s/bin/kp

STATUS=1; ATTEMPTS=0; CMD="kp config default-repository";
until [ $STATUS -eq 0 ] || $CMD || [ $ATTEMPTS -eq 12 ]; do
  sleep 5;
  $CMD;
  STATUS=$?; ATTEMPTS=$((attempts + 1));
done

# Create secrets for kpack to access registry and git server
kp secret create registry-credentials --registry $REGISTRY_HOST --registry-user $REGISTRY_USERNAME || true
kp secret create git-credentials --git-url $GIT_PROTOCOL://$GIT_HOST --git-user $GIT_USERNAME || true

# Create stack, store, and builder
kp clusterstack save base --build-image paketobuildpacks/build:base-cnb --run-image paketobuildpacks/run:base-cnb
kp clusterstore save default -b gcr.io/paketo-buildpacks/java:6.21.0 -b gcr.io/paketo-buildpacks/go:1.4.0
kp clusterbuilder save default --tag ${REGISTRY_HOST}/builder --stack base --store default --order /opt/workshop/scripts/kpack-builder-order.yaml
