class samba::params {
  $root_user = 'root'
  case $::osfamily {
    'Debian': {
      $smbservice        = 'smbd'
      $smbpackage        = 'samba'
      $smb_conf_filename = '/etc/samba/smb.conf'
      $smb_var_dir       = '/var/lib/samba'
      $var_group         = 'root'
      $root_group        = 'root'
    }
    'Solaris': {
      $smbservice        = 'cswsamba'
      $smbpackage        = 'CSWsamba'
      $smb_conf_filename = '/etc/opt/csw/samba/smb.conf'
      $smb_var_dir       = '/var/opt/csw/samba'
      $var_group         = 'bin'
      $root_group        = 'root'
    }
    'FreeBSD': {
      $smbservice        = 'samba_server'
      $smbpackage        = 'samba43'
      $smb_conf_filename = '/usr/local/etc/smb4.conf'
      $smb_var_dir       = '/var/samba'
      $var_group         = 'wheel'
      $root_group        = 'wheel'
    }
    default: {
      fail("::samba does not support osfamily ${::osfamily}")
    }
  }

  $smb_dfs_dir = "${smb_var_dir}/dfs"
}
