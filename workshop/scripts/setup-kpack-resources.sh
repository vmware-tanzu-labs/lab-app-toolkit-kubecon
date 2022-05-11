#!/bin/bash

#set -x
#
##STATUS=1; ATTEMPTS=0; CMD="kubectl get crd/builders.kpack.io -o name";
#STATUS=1; ATTEMPTS=0; CMD="kp config default-repository";
#until [ $STATUS -eq 0 ] || $CMD || [ $ATTEMPTS -eq 12 ]; do
#  sleep 5;
#  $CMD;
#  STATUS=$?; ATTEMPTS=$((attempts + 1));
#done
#
## Create secrets for kpack to access registry and git server
#kp secret create registry-credentials --registry $REGISTRY_HOST --registry-user $REGISTRY_USERNAME || true
#kp secret create git-credentials --git-url $GIT_PROTOCOL://$GIT_HOST --git-user $GIT_USERNAME || true
#
## Create stack, store, and builder
#kp clusterstack save base --build-image paketobuildpacks/build:1.1.58-base-cnb --run-image paketobuildpacks/run:1.1.58-base-cnb
#kp clusterstore save default -b gcr.io/paketo-buildpacks/java:6.21.0 -b gcr.io/paketo-buildpacks/go:1.4.0
#kp clusterbuilder save default --tag ${REGISTRY_HOST}/builder --stack base --store default --order /opt/workshop/scripts/kpack-builder-order.yaml
