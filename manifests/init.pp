# Class: storage
#
# This module manages storage
#
# Parameters: none
#
# Actions:
#
# Requires: see Modulefile
#
# Sample Usage:
#
class storage(
  $varlog,
  $tmp,
  $home,
  $usrlocalbin,
  $puppet,
  $squid,
  $aptcacher,
  $mysql,
  $bind,
  $rootfs_device = "") {
  
  contain storage::install
  contain storage::config
  
  contain storage::create_lvm_system

}
