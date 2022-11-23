# @summary Install and configure routinator
#
# Install and configure routinator
#
# @param package_name
#   routinator package name
# @param service_name
#   routinator service name
# @param rtr_bind
#   rtr bind address
# @param rtr_port
#   rtr port address
# @param http_bind
#   rtr bind address
# @param http_port
#   rtr port address
# @param basic_packages
#   packages needed before routinator
# @param config_source
#   configuration file source path
# @param config_path
#   configuration file destination path
# @param gpg_key_source
#   gpg repo key source address
# @param log_folder
#   log folder
# @param work_folder
#   working folder
# @param work_group
#   group used by routinator
# @param config_enable
#   configuration file to enable routinator
# @param config_enable_source
#   configuration source file to enable routinator
# @param repo_file
#   repository destination file
# @param repo_file_source
#   repository source file
# @param work_user
#   user used by routinator
# @param gpg_filename
#   filename for gpg key
# @param gpg_keyid
#   gpg key id
# @param apt_repo_content
#   apt source file content
# @param apt_repo_path
#   apt source file path
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
  String $apt_repo_source,
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
