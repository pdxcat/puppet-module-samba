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
      if (versioncmp($::operatingsystemrelease, '16.04') >= 0) {
        $manage_unit_files = true
        $smbd_unit_file = '/lib/systemd/system/smbd.service'
        $nmbd_unit_file = '/lib/systemd/system/nmbd.service'
        $samba_service_provider = 'systemd'
      }
      else {
        $samba_service_provider = undef
      }
    }
    'Solaris': {
      $smbservice        = 'cswsamba'
      $smbpackage        = 'CSWsamba'
      $smb_conf_filename = '/etc/opt/csw/samba/smb.conf'
      $smb_var_dir       = '/var/opt/csw/samba'
      $var_group         = 'bin'
      $root_group        = 'root'
      $samba_service_provider = undef
    }
    'FreeBSD': {
      $smbservice        = 'samba_server'
      $smbpackage        = 'samba44'
      $smb_conf_filename = '/usr/local/etc/smb4.conf'
      $smb_var_dir       = '/var/samba'
      $var_group         = 'wheel'
      $root_group        = 'wheel'
      $samba_service_provider = undef
    }
    default: {
      fail("::samba does not support osfamily ${::osfamily}")
    }
  }

  $smb_dfs_dir = "${smb_var_dir}/dfs"
}
