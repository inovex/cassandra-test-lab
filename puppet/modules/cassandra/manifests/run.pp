class cassandra::run {
  service { 'cassandra':
    ensure     => 'running',
    enable     => true,
    hasrestart => true,
    hasstatus  => false,
  }

  service { 'datastax-agent':
    ensure => 'running',
    enable => true,
  }
}
