#!/bin/sh
sudo apt-get update
sudo apt-get upgrade -y

# Instlacion Puppet
cd ~
mkdir Downloads
wget http://apt.puppetlabs.com/puppetlabs-release-precise.deb
sudo dpkg -i puppetlabs-release-precise.deb
sudo apt-get update

sudo apt-get install puppet -y

# Instalacion emacs
sudo apt-get install python-software-properties -y
sudo add-apt-repository ppa:cassou/emacs
sudo apt-get update
sudo apt-get install emacs24 -y
sudo apt-get install git-core -y



