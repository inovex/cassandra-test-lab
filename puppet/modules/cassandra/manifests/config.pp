class cassandra::config {
  $topology = hiera('topology')
  $seed_providers = hiera('seed_providers')
  $ip = hiera('ip')
  
  file { '/etc/cassandra/cassandra.yaml':
    ensure  => file,
    content => template('cassandra/cassandra.yaml.erb'),
    notify  => Service["cassandra"],
  }

  file { '/etc/cassandra/cassandra-rackdc.properties':
    ensure  => file,
    content => template('cassandra/cassandra-rackdc.properties.erb'),
    notify  => Service["cassandra"],
  }

  $opscenter_ip = hiera('opscenter_ip')

  file { '/var/lib/datastax-agent/conf/address.yaml':
    ensure  => file,
    content => template('cassandra/address.yaml.erb'),
    notify  => Service["datastax-agent"],
  }
}