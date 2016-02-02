define samba::share(
  $ensure                 = present,
  $acl_check_permissions  = 'NONE',
  $browseable             = 'NONE',
  $comment                = 'NONE',
  $create_mask            = 'NONE',
  $create_mask            = 'NONE',
  $dfree_command          = 'NONE',
  $directory_mask         = 'NONE',
  $force_create_mode      = 'NONE',
  $force_directory_mode   = 'NONE',
  $force_group            = 'NONE',
  $force_user             = 'NONE',
  $guest_ok               = 'NONE',
  $guest_only             = 'NONE',
  $inherit_acls           = 'NONE',
  $inherit_permissions    = 'NONE',
  $msdfs_proxy            = 'NONE',
  $msdfs_root             = 'NONE',
  $nfs4_acedup            = 'NONE',
  $nfs4_chown             = 'NONE',
  $nfs4_mode              = 'NONE',
  $path                   = 'NONE',
  $posix_locking          = 'NONE',
  $priority               = '20',
  $public                 = 'NONE',
  $vfs_objects            = 'NONE',
  $writeable              = 'NONE'
) {
  include ::samba

  concat::fragment { $name:
    ensure  => $ensure,
    target  => $samba::params::smb_conf_filename,
    content => template('samba/share.erb'),
    order   => $priority,
  }
}

