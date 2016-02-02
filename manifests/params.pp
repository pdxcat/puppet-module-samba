class samba::params {
  case $::osfamily {
    'Debian': {
      $smbservice        = 'smbd'
      $smbpackage        = 'samba'
      $smb_conf_filename = '/etc/samba/smb.conf'
    }
    'Solaris': {
      $smbservice        = 'cswsamba'
      $smbpackage        = 'CSWsamba'
      $smb_conf_filename = '/etc/opt/csw/samba/smb.conf'
    }
    'FreeBSD': {
      $smbservice        = 'samba_server'
      $smbpackage        = 'samba43'
      $smb_conf_filename = '/usr/local/etc/smb4.conf'
    }
    default: {
      fail("::samba does not support osfamily ${::osfamily}")
    }
  }
}
