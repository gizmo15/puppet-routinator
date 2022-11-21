# @summary Manage routinator package installation
class routinator::package {
  $package_name  = $routinator::params::package_name

  case $facts['os']['name'] {
    'FreeBSD': {
      package { 'install_routinator':
        ensure => 'present',
        name   => $package_name,
      }
    }
    'CentOS': {
      package { 'install_routinator':
        ensure => 'present',
        name   => $package_name,
      }
    }
    default: {
      # Debian/Ubuntu
      $basic_packages = ['ca-certificates', 'curl', 'lsb-release']
      package { $basic_packages:
        ensure => present,
      }
      package { 'install_routinator':
        ensure => 'present',
        name   => $package_name,
      }
    }
  }
}
