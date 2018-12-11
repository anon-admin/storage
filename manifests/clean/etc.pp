class storage::clean::etc {
  exec { ["/usr/bin/find /etc -type f -name '*~' -delete",
          "/usr/bin/find /etc -type f -name '\#*\#' -delete"]:
    cwd => "/etc",
  }
}
