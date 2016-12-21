if [[ "$(id -u)" -ne 0 ]]; then
  # No Root
  is_root=false
else
  # Root
  is_root=true
fi

@@assertNoOut '@is-root'

@@assertExec '@is-root' ${is_root}
