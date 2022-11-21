# @summary Configure routinator installation
class routinator::config {
  assert_private()

  case $facts['os']['name'] {
    'FreeBSD': {
      file { $routinator::log_folder:
        ensure => directory,
        owner  => $routinator::work_user,
        group  => $routinator::work_group,
        mode   => '0755',
      }

      file { $routinator::work_folder:
        ensure => directory,
        owner  => $routinator::work_user,
        group  => $routinator::work_group,
        mode   => '2755',
      }

      file { 'routinator_enable':
        ensure => file,
        path   => $routinator::config_enable,
        source => $routinator::config_enable_source,
      }

      exec { 'routinator_init':
        command => "su -m ${routinator::work_user} -c 'routinator -c ${routinator::config_path} init --accept-arin-rpa'",
        unless  => "cat ${routinator::work_folder}/tals/ripe.tal",
      }
    }
    'CentOS': {
      file { 'repo_file':
        ensure => file,
        path   => $routinator::repo_file,
        source => $routinator::repo_file_source,
      }

      exec { "rpm --import ${routinator::gpg_key_source}":
        provider => 'shell',
        command  => "rpm --import ${routinator::gpg_key_source}",
        unless   => 'rpm -q gpg-pubkey --qf \'%{NAME}-%{VERSION}-%{RELEASE}\t%{SUMMARY}\n\' | grep NLnet',
      }
    }
    default: {
      # Debian/Ubuntu
      file { 'repo_key':
        ensure => file,
        path   => "/tmp/${routinator::gpg_filename}",
        source => $routinator::gpg_key_source,
        notify => Exec["gpg --dearmor ${routinator::gpg_filename}"],
      }

      exec { "gpg --dearmor ${routinator::gpg_filename}":
        provider    => 'shell',
        cwd         => '/usr/share/keyrings/',
        command     => "gpg --dearmor < /tmp/${routinator::gpg_filename} > ${routinator::gpg_filename}",
        refreshonly => true,
      }

      file { 'routinator_sources_file':
        ensure  => file,
        path    => $routinator::apt_repo_path,
        content => $routinator::apt_repo_content,
      }
    }
  }

  file { 'routinator_config':
    ensure  => file,
    path    => $routinator::config_path,
    content => template('routinator/routinator.conf.erb'),
    notify  => Service['routinator_service'],
  }
}
