class system_base {

  $ip = hiera('ip')

  host { 'localhost':
    ip => $ip,
  }


  $apt_keys= ['cassandra.gpg.key']
  system_base::aptkey { $apt_keys: 
  }

  file {'/etc/apt/sources.list.d/custom_sources.list':
    ensure => present,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    source => 'puppet:///modules/system_base/custom_sources.list',
  }

  exec { 'apt-get-update':
    path        => '/usr/bin:/usr/sbin:/bin:/usr/local/bin',
    command     => 'apt-get update',
    require     =>  [File['/etc/apt/sources.list.d/custom_sources.list'], System_base::Aptkey['cassandra.gpg.key']]
  }


  $basic_packages = ['vim', 'dstat', 'sysstat', 'iftop', 'tree', 'htop']
  package { $basic_packages:
    ensure => 'installed',
    require => Exec['apt-get-update'],
  }

  $purge_packages= []
  package { $purge_packages:
    ensure => 'purged',
    require => Exec['apt-get-update'],
  }

  define aptkey ($key_name = $title) {
    file {"/tmp/$key_name":
      ensure => present,
      owner  => 'root',
      group  => 'root',
      mode   => '0644',
      source => "puppet:///modules/system_base/$key_name",
    }
    exec { "Import $key_name to apt keystore":
      path        => '/bin:/usr/bin',
      environment => 'HOME=/root',
      command     => "apt-key add /tmp/$key_name",
      user        => 'root',
      group       => 'root',
      logoutput   => on_failure,
      refreshonly => true,
      subscribe   => File["/tmp/$key_name"],
    }
  }

}