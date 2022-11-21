# @summary Install and configure routinator
#
# Install and configure routinator
#
# @param rtr_bind
#   rtr bind address
# @param rtr_port
#   rtr port address
# @param http_bind
#   rtr bind address
# @param http_port
#   rtr port address
class routinator (
  String $rtr_bind     = '127.0.0.1',
  Integer $rtr_port    = 3323,
  String $http_bind    = '127.0.0.1',
  Integer $http_port   = 8323,
) inherits routinator::params {
  contain routinator::package
  contain routinator::config
  contain routinator::service

  Class['routinator::package'] -> Class['routinator::config'] ~> Class['routinator::service']
}
