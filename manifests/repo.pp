# @summary Manage repo for routinator installation
class routinator::repo {
  assert_private()

  if $facts['os']['name'] == 'CentOS' {
    file { $routinator::repo_file:
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
  if $facts['os']['name'] =~ /^(Debian|Ubuntu)$/ {
    # Debian/Ubuntu
    file { $routinator::gpg_filename:
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

    file { $routinator::apt_repo_path:
      ensure  => file,
      path    => $routinator::apt_repo_path,
      content => template("${module_name}/${routinator::apt_repo_source}"),
    }
  }
}
