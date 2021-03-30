if [[ "$(id -u)" -ne 0 ]]; then
  # No Root
  is_root=false
else
  # Root
  is_root=true
fi

@@assert.noOut '@isRoot'

@@assert.exec '@isRoot' ${is_root}

# vim: filetype=sh tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab
