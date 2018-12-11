class storage::config inherits storage {
  service { "lvm2-lvmetad":
    ensure => running,
    enable  => true,
  }

  file_line { 'lmvconf lvmetad enabled':
    ensure => present,
    path   => '/etc/lvm/lvm.conf',
    line   => '    use_lvmetad = 1',
    match  => '^[ ]*use_lvmetad = ',
  }
}