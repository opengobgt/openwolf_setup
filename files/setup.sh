#!/bin/sh 
puppet apply -l /tmp/mides_setup.log --modulepath=../modules ../manifests/default.pp 
