class opscenter {
  package { 'opscenter':
    ensure => 'installed',
  }

  service { 'opscenterd':
    ensure  => 'running',
    require => Package['opscenter'],
  }
}
