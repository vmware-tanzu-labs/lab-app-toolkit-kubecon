##!/bin/bash
#
#set -x
#
#STATUS=1; ATTEMPTS=0; CMD='kubectl get crd/clustersupplychains.carto.run';
#until [ $STATUS -eq 0 ] || $CMD || [ $ATTEMPTS -eq 12 ]; do
#  sleep 5;
#  $CMD;
#  STATUS=$?; ATTEMPTS=$((attempts + 1));
#done
#
## Create example supply chain values file
#envsubst < ~/exercises/supply-chain/supply-chain.yaml.in > ~/exercises/supply-chain/supply-chain.yaml
#kapp deploy -a supply-chain -f ~/exercises/supply-chain/cluster -f ~/exercises/supply-chain/app-operator --yes
