class samba(
  $smb_conf_filename    = $samba::params::smb_conf_filename,
) {
  include ::samba::params

  # lint:ignore:selector_inside_resource

  package { $samba::params::smbpackage:
    name     => $samba::params::smbpackage,
    provider => $::osfamily ? {
      'Solaris' => pkgutil,
      default   => undef,
    }
  }
  # lint:endignore

  ->

  file { $::samba::params::smb_var_dir:
    ensure => 'directory',
    owner  => $::samba::params::root_user,
    group  => $::samba::params::var_group,
    mode   => '0755',
  }

  ->

  file { $::samba::params::smb_dfs_dir:
    ensure => 'directory',
    owner  => $::samba::params::root_user,
    group  => $::samba::params::root_group,
    mode   => '0755',
  }

  service {$samba::params::smbservice:
    ensure => running,
    name   => $samba::params::smbservice,
    enable => true,
  }


  concat { $samba::params::smb_conf_filename:
    ensure => present,
    owner  => $samba::params::root_user,
    group  => $samba::params::root_group,
    mode   => '0644',
    notify => Service[$samba::params::smbservice],
  }

}
