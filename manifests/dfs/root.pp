define samba::dfs::root(
  $comment              = undef,
  $public               = undef,
  $ensure               = present,
  $priority             = '20',
  $links                = [],
) {
  include ::samba

  $msdfs_root = 'yes'

  $dfs_root_path = "${::samba::params::smb_dfs_dir}/${name}"

  concat::fragment { $name:
    ensure  => $ensure,
    target  => $::samba::params::smb_conf_filename,
    content => template('samba/share.erb'),
    order   => $priority,
  }

  $directory_ensure = $ensure ? {
    'present' => 'directory',
    default   => 'absent',
  }

  file { $dfs_root_path:
    ensure => $directory_ensure,
    owner  => $::samba::params::root_group,
    group  => $::samba::params::root_user,
    mode   => '0775',
  }

  $links.each |String $link_name, Hash $link_options| {
    $link_hash = {
      # lint:ignore:variable_scope
      "${dfs_root_path}/${link_name}" => $link_options
      # lint:endignore
    }

    create_resources('file', $link_hash)
  }
}
