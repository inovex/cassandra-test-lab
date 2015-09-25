class cassandra::setup {
  $packages = ['dsc22', 'cassandra-tools', 'datastax-agent']
  package { $packages:
    ensure  => 'present',
    require => [
      Exec['apt-get-update'],
      Class['java']
    ],
  }

  exec { 'cassandra-init-stop':
    command => "/bin/sh -c '/etc/init.d/cassandra stop'",
    require => Package['dsc22'],
    unless  => '/usr/bin/test -f /var/lib/cassandra/data/.initialized_cassandra',
  }

  exec { 'remove-default-files':
    command => '/bin/rm -rf /var/lib/cassandra/data/system/*',
    require => Exec['cassandra-init-stop'],
    unless  => '/usr/bin/test -f /var/lib/cassandra/data/.initialized_cassandra',
  }

  file { 'cassandra_data_dir':
    ensure  => directory,
    path    => '/var/lib/cassandra/data/',
    owner   => 'cassandra',
    group   => 'cassandra',
    mode    => '0775',
    require => Package['dsc22'],
  }

  file { 'cassandra-init-marker':
    ensure  => 'present',
    path    => '/var/lib/cassandra/data/.initialized_cassandra',
    owner   => 'cassandra',
    group   => 'cassandra',
    require => [
      Exec['remove-default-files'],
      File['cassandra_data_dir'],
    ],
  }
}
