# @summary Manage routinator package installation
class routinator::package {
  assert_private()

  package { 'routinator_package':
    ensure => 'present',
    name   => $routinator::package_name,
  }

  $routinator::basic_packages.each |$package| {
    package { $package:
      ensure => 'present',
    }
  }
}
