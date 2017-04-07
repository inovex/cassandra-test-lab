node 'node-1', 'node-2', 'node-3', 'node-4' {

  class {'system_base': } ->
  class { 'java':
    distribution => 'jdk',
  }
  ->
  class {'cassandra': }
}

node 'node-5' {

  class {'system_base': } ->
  class { 'java':
    distribution => 'jdk',
  }
  ->
  class {'opscenter': }
}
