if [[ "$(id -u)" -ne 0 ]]; then
  # No Root
  is_root=false
else
  # Root
  is_root=true
fi

@@assert.noOut '@is-root'

@@assert.exec '@is-root' ${is_root}
