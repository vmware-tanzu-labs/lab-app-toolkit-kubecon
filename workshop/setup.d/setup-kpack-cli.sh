#!/bin/bash

#set -eo pipefail
#
## Install kp and pack CLIs
#mkdir -p /home/eduk8s/bin
#
#KP_VERSION=0.5.0
#PACK_VERSION=0.26.0
#
#curl --fail -L -o /home/eduk8s/bin/kp https://github.com/vmware-tanzu/kpack-cli/releases/download/v$KP_VERSION/kp-linux-$KP_VERSION && chmod 755 /home/eduk8s/bin/kp
#curl --fail -sSL "https://github.com/buildpacks/pack/releases/download/v$PACK_VERSION/pack-v$PACK_VERSION-linux.tgz" | tar -C /home/eduk8s/bin/ -xzv pack
#
#/opt/workshop/scripts/setup-kpack-resources.sh &
