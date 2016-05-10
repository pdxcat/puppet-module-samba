class samba(
  $smb_conf_filename = $samba::params::smb_conf_filename,
  $disable_winbindd  = true,
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

  if ($disable_winbindd and $::osfamily == 'FreeBSD') {
    file_line { 'disable winbindd':
      path  => '/usr/local/etc/rc.d/samba_server',
      line  => '            samba_daemons="nmbd smbd" # winbindd"',
      match => '^\s+samba_daemons="nmbd smbd winbindd"',
    }
  }

  concat { $samba::params::smb_conf_filename:
    ensure => present,
    owner  => $samba::params::root_user,
    group  => $samba::params::root_group,
    mode   => '0644',
    notify => Service[$samba::params::smbservice],
  }

}
