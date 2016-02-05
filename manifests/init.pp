class samba(
  $smb_conf_filename    = $samba::params::smb_conf_filename,
) {
  include ::samba::params

  package { $samba::params::smbpackage:
    ensure   => latest,
    name     => $samba::params::smbpackage,
    provider => $::osfamily ? {
      'Solaris' => pkgutil,
      default   => undef,
    }
  }

  ->

  file { $::samba::params::smb_var_dir:
    ensure => 'directory',
    owner  => 'root',
    mode   => '0755',
  }

  ->

  file { $::samba::params::smb_dfs_dir:
    ensure => 'directory',
    owner  => 'root',
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
