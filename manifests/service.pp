# @summary Handle routinator service
#
class routinator::service (
) {
  assert_private()

  service { 'routinator_service':
    ensure     => 'running',
    name       => $routinator::service_name,
    enable     => true,
    hasrestart => true,
  }
}
