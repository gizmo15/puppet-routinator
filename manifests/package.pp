# @summary Manage routinator package installation
class routinator::package {
  assert_private()

  package { 'routinator_package':
    ensure => 'present',
    name   => $routinator::package_name,
  }

  package { 'routinator_basic_packages':
    ensure => 'present',
    name   => $routinator::basic_packages,
  }
}
