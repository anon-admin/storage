class storage::clean::system {
  include storage::clean

  include simple_puppet::clean

  contain storage::clean::log
  contain storage::clean::tmp


}