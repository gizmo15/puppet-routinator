# @summary Parameters for routinator
class routinator::params {
  $package_name  = 'routinator'
  $service_name  = 'routinator'

  $os_name       = downcase($facts['os']['name'])
  $config_source = 'routinator/routinator.conf.erb'

  case $facts['os']['name'] {
    'FreeBSD': {
      $config_path          = '/usr/local/etc/routinator/routinator.conf'
      $log_folder           = '/var/log/routinator'
      $work_user            = 'routinator'
      $work_group           = 'wheel'
      $work_folder          = '/var/routinator'
      $config_enable        = '/etc/rc.conf.d/routinator'
      $config_enable_source = 'puppet:///modules/routinator/freebsd/routinator_enable.conf'
    }
    'CentOS': {
      $repo_file        = '/etc/yum.repos.d/nlnetlabs.repo'
      $repo_file_source = 'puppet:///modules/routinator/centos/nlnetlabs.repo'
      $gpg_key_source   = 'https://packages.nlnetlabs.nl/aptkey.asc'
      $config_path      = '/etc/routinator/routinator.conf'
    }
    default: {
      # Debian/Ubuntu
      $gpg_filename     = 'nlnetlabs-archive-keyring.gpg'
      $gpg_keyid        = '210528A3130ABAAEFFC8680494E92A0708C4CC43'
      $gpg_key_source   = 'https://packages.nlnetlabs.nl/aptkey.asc'
      $apt_repo_content = "deb [arch=${facts['os']['architecture']} signed-by=/usr/share/keyrings/nlnetlabs-archive-keyring.gpg] https://packages.nlnetlabs.nl/linux/${os_name} ${facts['os']['distro']['codename']} main\n"
      $apt_repo_path    = '/etc/apt/sources.list.d/nlnetlabs.list'
      $config_path      = '/etc/routinator/routinator.conf'
    }
  }
}
