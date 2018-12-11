class storage::lvm {
  define createlv ($vgname, $size, $fstype, $mountpoint) {
    $lvname = $name

    exec { "create /dev/mapper/${vgname}-${lvname}":
      command  => "lvcreate -L ${size} -n ${lvname} ${vgname} && mkfs.${fstype} /dev/mapper/${vgname}-${lvname}",
      provider => shell,
      onlyif   => "/usr/bin/test ! -b /dev/mapper/${vgname}-${lvname}",
      before   => Mount[$mountpoint],
    }

    if ($fstype == "ext2") or ($fstype == "ext3") or ($fstype == "ext4") {
      Exec["create /dev/mapper/${vgname}-${lvname}"] ~> Exec["e2label /dev/mapper/${vgname}-${lvname} ${vgname}-${lvname}"]
      Exec["create /dev/mapper/${vgname}-${lvname}"] -> Exec["e2label /dev/mapper/${vgname}-${lvname} ${vgname}-${lvname}"]

      exec { "e2label /dev/mapper/${vgname}-${lvname} ${vgname}-${lvname}":
        refreshonly => true,
        provider    => shell,
      }
    }
  }
}