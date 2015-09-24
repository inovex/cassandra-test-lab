#!/bin/bash
wget -q https://apt.puppetlabs.com/puppetlabs-release-precise.deb
dpkg -i puppetlabs-release-precise.deb
apt-get update
apt-get -qq install -y puppet

mkdir -p /etc/puppet/modules
puppet module install puppetlabs/java --modulepath=/etc/puppet/modules