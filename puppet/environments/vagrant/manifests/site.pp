class { 'java':
  distribution => 'jdk',
}

include system_base

node 'node-1', 'node-2', 'node-3', 'node-4' {
  include cassandra
  

  Class['system_base'] -> Class['java'] -> Class['cassandra'] 
}

node 'node-5' {
  include opscenter
  
  Class['system_base'] -> Class['opscenter']
}

