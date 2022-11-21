# @summary Handle routinator service
#
# @param service_name
#   Routinator service name, OS dependant
class routinator::service (
  String $service_name  = $routinator::params::service_name,
) inherits routinator::params {
  service { 'routinator_service':
    ensure     => 'running',
    name       => $service_name,
    enable     => true,
    hasrestart => true,
  }
}
