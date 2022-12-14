# Reference
<!-- DO NOT EDIT: This document was generated by Puppet Strings -->

## Table of Contents

**Classes**

* [`routinator`](#routinator): Install and configure routinator
* [`routinator::config`](#routinatorconfig): Configure routinator installation
* [`routinator::package`](#routinatorpackage): Manage routinator package installation
* [`routinator::repo`](#routinatorrepo): Manage repo for routinator installation
* [`routinator::service`](#routinatorservice): Handle routinator service

## Classes

### routinator

Install and configure routinator

#### Parameters

The following parameters are available in the `routinator` class.

##### `package_name`

Data type: `String`

routinator package name

##### `service_name`

Data type: `String`

routinator service name

##### `rtr_bind`

Data type: `String`

rtr bind address

##### `rtr_port`

Data type: `Integer`

rtr port address

##### `http_bind`

Data type: `String`

rtr bind address

##### `http_port`

Data type: `Integer`

rtr port address

##### `basic_packages`

Data type: `Array`

packages needed before routinator

##### `config_source`

Data type: `String`

configuration file source path

##### `config_path`

Data type: `String`

configuration file destination path

##### `gpg_key_source`

Data type: `String`

gpg repo key source address

##### `log_folder`

Data type: `String`

log folder

##### `work_folder`

Data type: `String`

working folder

##### `work_group`

Data type: `String`

group used by routinator

##### `config_enable`

Data type: `String`

configuration file to enable routinator

##### `config_enable_source`

Data type: `String`

configuration source file to enable routinator template

##### `repo_file`

Data type: `String`

repository destination file

##### `repo_file_source`

Data type: `String`

repository source file

##### `work_user`

Data type: `String`

user used by routinator

##### `gpg_filename`

Data type: `String`

filename for gpg key

##### `gpg_keyid`

Data type: `String`

gpg key id

##### `apt_repo_source`

Data type: `String`

apt source file template

##### `apt_repo_path`

Data type: `String`

apt source file path

### routinator::config

Configure routinator installation

### routinator::package

Manage routinator package installation

### routinator::repo

Manage repo for routinator installation

### routinator::service

Handle routinator service

