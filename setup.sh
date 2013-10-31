#!/bin/sh 
sudo puppet apply --verbose --modulepath=./modules ./manifests/default.pp 
