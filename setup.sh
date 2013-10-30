#!/bin/sh 
puppet apply --verbose --modulepath=./modules ./manifests/default.pp 
