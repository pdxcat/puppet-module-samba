define samba::share(
  $ensure                 = present,
  $acl_check_permissions  = undef,
  $browseable             = undef,
  $comment                = undef,
  $create_mask            = undef,
  $dfree_command          = undef,
  $directory_mask         = undef,
  $force_create_mode      = undef,
  $force_directory_mode   = undef,
  $force_group            = undef,
  $force_user             = undef,
  $guest_ok               = undef,
  $guest_only             = undef,
  $inherit_acls           = undef,
  $inherit_permissions    = undef,
  $msdfs_proxy            = undef,
  $msdfs_root             = undef,
  $nfs4_acedup            = undef,
  $nfs4_chown             = undef,
  $nfs4_mode              = undef,
  $path                   = undef,
  $posix_locking          = undef,
  $priority               = 20,
  $public                 = undef,
  $vfs_objects            = undef,
  $writeable              = undef
) {
  include ::samba

  $samba_path = $path

  concat::fragment { $name:
    ensure  => $ensure,
    target  => $samba::smb_conf_filename,
    content => template('samba/share.erb'),
    order   => $priority,
  }
}

