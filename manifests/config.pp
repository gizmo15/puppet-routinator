# @summary Configure routinator installation
class routinator::config {
  $config_path          = $routinator::params::config_path
  $config_source        = $routinator::params::config_source
  $log_folder           = $routinator::params::log_folder
  $work_user            = $routinator::params::work_user
  $work_group           = $routinator::params::work_group
  $work_folder          = $routinator::params::work_folder
  $config_enable        = $routinator::params::config_enable
  $config_enable_source = $routinator::params::config_enable_source

  $rtr_bind             = $routinator::rtr_bind
  $rtr_port             = $routinator::rtr_port
  $http_bind            = $routinator::http_bind
  $http_port            = $routinator::http_port

  case $facts['os']['name'] {
    'FreeBSD': {
      file { $log_folder:
        ensure => 'directory',
        owner  => $work_user,
        group  => $work_group,
        mode   => '0755',
      }

      file { $work_folder:
        ensure => 'directory',
        owner  => $work_user,
        group  => $work_group,
        mode   => '2755',
      }

      file { 'routinator_enable':
        ensure => file,
        path   => $config_enable,
        source => $config_enable_source,
      }

      exec { 'routinator_init':
        command => "su -m ${work_user} -c 'routinator -c ${config_path} init --accept-arin-rpa'",
        unless  => "cat ${work_folder}/tals/ripe.tal",
      }
    }
    'CentOS': {
      $repo_file        = $routinator::params::repo_file
      $repo_file_source = $routinator::params::repo_file_source
      $gpg_key_source   = $routinator::params::gpg_key_source

      file { 'repo_file':
        ensure => file,
        path   => $repo_file,
        source => $repo_file_source,
      }

      exec { "rpm --import ${gpg_key_source}":
        provider => 'shell',
        command  => "rpm --import ${gpg_key_source}",
        unless   => 'rpm -q gpg-pubkey --qf \'%{NAME}-%{VERSION}-%{RELEASE}\t%{SUMMARY}\n\' | grep NLnet',
      }
    }
    default: {
      # Debian/Ubuntu
      $gpg_keyid        = $routinator::params::gpg_keyid
      $gpg_key_source   = $routinator::params::gpg_key_source
      $filename         = $routinator::params::gpg_filename
      $apt_repo_path    = $routinator::params::apt_repo_path
      $apt_repo_content = $routinator::params::apt_repo_content

      file { 'repo_key':
        ensure => file,
        path   => "/tmp/${filename}",
        source => $gpg_key_source,
        notify => Exec["gpg --dearmor ${filename}"],
      }

      exec { "gpg --dearmor ${filename}":
        provider    => 'shell',
        cwd         => '/usr/share/keyrings/',
        command     => "gpg --dearmor < /tmp/${filename} > ${filename}",
        refreshonly => true,
      }

      file { 'routinator_sources_file':
        ensure  => file,
        path    => $apt_repo_path,
        content => $apt_repo_content,
      }
    }
  }

  file { 'routinator_config':
    ensure  => file,
    path    => $config_path,
    content => template($config_source),
    notify  => Service['routinator_service'],
  }
}
