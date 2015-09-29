#!/bin/bash
wget -q https://apt.puppetlabs.com/puppetlabs-release-wheezy.deb
dpkg -i puppetlabs-release-wheezy.deb
apt-get update -qq
DEBIAN_FRONTEND=noninteractive apt-get -qq install -y puppet

mkdir -p /etc/puppet/modules
puppet module install puppetlabs/java --modulepath=/etc/puppet/modules
