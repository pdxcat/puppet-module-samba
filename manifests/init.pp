class samba(
  $smb_conf_filename    = $samba::params::smb_conf_filename,
) {
  include ::samba::params

  package { $samba::params::smbpackage:
    ensure   => latest,
    name     => $samba::params::smbpackage,
    provider => $osfamily ? {
      'Solaris' => pkgutil,
      default   => undef,
    }
  }

  service {$samba::params::smbservice:
    ensure => running,
    name   => $samba::params::smbservice,
    enable => true,
  }

  concat { $samba::params::smb_conf_filename:
    ensure => present,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    notify => Service[$samba::params::smbservice],
  }

}
