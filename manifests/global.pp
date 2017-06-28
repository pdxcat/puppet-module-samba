define samba::global(
  $bind_interfaces_only      = undef,
  $client_ldap_sasl_wrapping = undef,
  $dns_proxy                 = undef,
  $encrypt_passwords         = undef,
  $host_msdfs                = undef,
  $hosts_allow               = undef,
  $idmap_gid                 = undef,
  $idmap_uid                 = undef,
  $interfaces                = undef,
  $load_printers             = undef,
  $local_master              = undef,
  $log_file                  = undef,
  $log_level                 = undef,
  $max_log_size              = undef,
  $max_protocol              = undef,
  $min_protocol              = undef,
  $netbios_name              = undef,
  $panic_action              = undef,
  $password_server           = undef,
  $realm                     = undef,
  $remote_announce           = undef,
  $security                  = undef,
  $server_string             = undef,
  $socket_options            = undef,
  $strict_locking            = undef,
  $syslog                    = undef,
  $unix_extensions           = undef,
  $wide_links                = undef,
  $wins_server               = undef,
  $workgroup                 = undef,
  $ensure                    = present,
  $priority                  = 1,
) {
  include ::samba

  concat::fragment { $name:
    ensure  => $ensure,
    target  => $samba::params::smb_conf_filename,
    content => template('samba/global.erb'),
    order   => $priority,
  }
}
