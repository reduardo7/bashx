## [*]
## Check if running as ROOT, or exit from script.
##
## Params:
##   *: {String} Message.
##      Optional. Default: "This script must be run as root!".

if ! @isRoot ; then
  local message="${*:-This script must be run as root!}"
  @app.error "$message"
fi

# vim: filetype=sh tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab
