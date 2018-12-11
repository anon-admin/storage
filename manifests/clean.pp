class storage::clean (
  $varlog = $storage::varlog,
  $tmp = $storage::tmp,
  $home = $storage::home,
  $rootfs_device = $storage::rootfs_device
) inherits storage {
  file { "/usr/tidy": ensure => directory, }

  mount { "/usr/tidy":
    ensure  => mounted,
    atboot  => false,
    require => File["/usr/tidy"],
  }

  if ($lsbdistcodename == "wheezy") or ($architecture == "amd64") {
    Mount["/usr/tidy"] {
      device  => "/",
      fstype  => "none",
      options => "bind,rw",
    }

  } else {
    if ($::blockdevice_sda_vendor == "QEMU") or ($::blockdevice_sdb_vendor == "QEMU") {
      Mount["/usr/tidy"] {
        device  => "/",
        fstype  => "none",
        options => "bind,rw",
      }

    } else {
      case "${rootfs_device}" {
        "" : {
          fail("rootfs_device not setted in hiera/storage")
        }
        default: {
          Mount["/usr/tidy"] {
            device  => "${rootfs_device}",
            fstype  => "ext4",
            options => "defaults,noatime",
          }
        }
      }

    }
  }

  # /dev/mmcblk0p2  /usr/tidy       ext4    defaults,noatime        0       0


  if $varlog {
    tidy { "/usr/tidy/var/log":
      recurse => true,
      backup  => false,
      size    => "100m",
      age     => "5w",
      require => Mount["/usr/tidy", "/var/log"],
    }
  }

  if $tmp {
    tidy { "/usr/tidy/tmp":
      recurse => true,
      backup  => false,
      size    => "100m",
      age     => "5w",
      require => Mount["/usr/tidy", "/tmp"],
    }
  }

  if $home {
    tidy { "/usr/tidy/home":
      recurse => true,
      backup  => false,
      size    => "100m",
      age     => "5w",
      require => Mount["/usr/tidy", "/home"],
    }
  }

  contain storage::clean::etc

}

