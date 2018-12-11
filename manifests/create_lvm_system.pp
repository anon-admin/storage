class storage::create_lvm_system inherits storage {
  
  $vgname = "system"

  if $storage::varlog {
    storage::lvm::createlv { "varlog":
      vgname     => $vgname,
      size       => "512M",
      fstype     => "ext2",
      mountpoint => "/var/log"
    }
    mount { "/var/log":
      atboot  => true,
      ensure  => mounted,
      fstype  => "ext2",
      options => "defaults",
      dump    => 0,
      pass    => 1,
      device  => "/dev/mapper/system-varlog",
    }

  }

  if $storage::tmp {
    storage::lvm::createlv { "tmp":
      vgname     => $vgname,
      size       => "512M",
      fstype     => "ext2",
      mountpoint => "/tmp"
    }

    mount { "/tmp":
      atboot  => true,
      ensure  => mounted,
      fstype  => "ext2",
      options => "defaults",
      dump    => 0,
      pass    => 1,
      device  => "/dev/mapper/system-tmp",
    }

  }

  if $storage::home {
    storage::lvm::createlv { "home":
      vgname     => $vgname,
      size       => "2G",
      fstype     => "ext4",
      mountpoint => "/home"
    }

    mount { "/home":
      atboot  => true,
      ensure  => mounted,
      fstype  => "ext4",
      options => "defaults",
      dump    => 0,
      pass    => 1,
      device  => "/dev/mapper/system-home",
    }

  }

  file { "/var/log":
    ensure => directory,
    before => Tidy["/var/log"],
  }

  file { "/tmp":
    ensure => directory,
    before => Tidy["/tmp"],
  }

  contain storage::clean::system

}
