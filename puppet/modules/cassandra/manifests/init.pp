class cassandra {
  class {"cassandra::setup": } ->
  class {'cassandra::config': } ->
  class {"cassandra::run": }
}
