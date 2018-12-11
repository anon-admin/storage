class storage::clean::tmp inherits storage {

# attention, penser a deplacer le cron logrotate de daily a hourly
  
  tidy { "/tmp":
    path    => '/tmp',
    rmdirs  => false,
    age     => '2w',
    recurse => true,
    backup  => false,
  }

  if $storage::tmp {
    Tidy["/tmp"] {
      require => [ Mount["/tmp"], Tidy["/usr/tidy/tmp"] ],
    }
  }

  include rsyslog

}