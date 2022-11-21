# @summary Install and configure routinator
#
# Install and configure routinator
#
# @param rtr_bind
#   rtr bind address
# @param rtr_port
#   rtr port address
# @param http_bind
#   rtr bind address
# @param http_port
#   rtr port address
class routinator (
  # Common
  String $package_name,
  String $service_name,
  String $rtr_bind,
  Integer $rtr_port,
  String $http_bind,
  Integer $http_port,
  Array $basic_packages,
  String $config_source,
  String $config_path,
  String $gpg_key_source,

  # FreeBSD
  String $log_folder,
  String $work_folder,
  String $work_user,
  String $work_group,
  String $config_enable,
  String $config_enable_source,

  # CentOS
  String $repo_file,
  String $repo_file_source,

  # Debian
  String $gpg_filename,
  String $gpg_keyid,
  String $apt_repo_content,
  String $apt_repo_path,

) {
  contain routinator::repo
  contain routinator::package
  contain routinator::config
  contain routinator::service

  Class['routinator::repo']
  -> Class['routinator::package']
  -> Class['routinator::config']
  ~> Class['routinator::service']
}
