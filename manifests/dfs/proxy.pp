define samba::dfs::proxy(
  $msdfs_proxy,
  $msdfs_root           = undef,
  $comment              = undef,
  $public               = undef,
  $ensure               = present,
  $priority             = '20'
) {
  include ::samba

  concat::fragment { $name:
    ensure  => $ensure,
    target  => $::samba::smb_conf_filename,
    content => template('samba/share.erb'),
    order   => $priority,
  }
}
