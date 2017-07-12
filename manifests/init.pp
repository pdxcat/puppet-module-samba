class samba(
  $smb_conf_filename = $samba::params::smb_conf_filename,
  $samba_service      = $samba::params::smbservice,
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

  if ($::samba::params::manage_unit_files) {
    ::systemd::unit_file {
      'smbd.service':
        source => 'puppet:///modules/samba/units/smbd.service',
        before => Service[$samba_service];
      'nmbd.service':
        source => 'puppet:///modules/samba/units/nmbd.service',
        before => Service[$samba_service];
    }
  }

  service {$samba_service:
    ensure   => running,
    name     => $samba_service,
    provider => $::samba::params::samba_service_provider,
    enable   => true,
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
