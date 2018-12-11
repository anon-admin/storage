class storage::install inherits storage {
  package { "lvm2": ensure => latest, }
}