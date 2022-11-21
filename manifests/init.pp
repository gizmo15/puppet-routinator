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
  String $rtr_bind,
  Integer $rtr_port,
  String $http_bind,
  Integer $http_port,
) {
  contain routinator::package
  contain routinator::config
  contain routinator::service

  Class['routinator::package'] -> Class['routinator::config'] ~> Class['routinator::service']
}
