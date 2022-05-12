#!/bin/bash

set -x

# Clone sample application to session git server
cd /opt/git/repositories
git clone --bare https://github.com/ciberkleid/hello-go.git

