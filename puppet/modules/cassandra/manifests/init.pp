class cassandra {
  include cassandra::setup
  include cassandra::config
  include cassandra::run

  Class["cassandra::setup"] -> Class['cassandra::config'] -> Class["cassandra::run"]
}