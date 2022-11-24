# @summary Configure routinator installation
class routinator::config {
  assert_private()

  if $facts['os']['name'] == 'FreeBSD' {
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

    file { $routinator::config_enable:
      ensure => file,
      path   => $routinator::config_enable,
      source => "puppet:///modules/${module_name}/${routinator::config_enable_source}",
    }

    exec { "routinator -c ${routinator::config_path} init --accept-arin-rpa":
      command => "su -m ${routinator::work_user} -c 'routinator -c ${routinator::config_path} init --accept-arin-rpa'",
      unless  => "cat ${routinator::work_folder}/tals/ripe.tal",
    }
  }

  file { 'routinator_config':
    ensure  => file,
    path    => $routinator::config_path,
    content => template("${module_name}/routinator.conf.erb"),
    notify  => Service['routinator_service'],
  }
}
