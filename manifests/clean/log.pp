class storage::clean::log inherits storage {
  # attention, penser a deplacer le cron logrotate de daily a hourly

  tidy { "/var/log":
    path    => '/var/log',
    rmdirs  => false,
    age     => '2w',
    recurse => true,
    backup  => false,
  }

  if $storage::varlog {
    Tidy["/var/log"] {
      require => [Mount["/var/log"], Tidy["/usr/tidy/var/log"]], }
  }
  include rsyslog

}