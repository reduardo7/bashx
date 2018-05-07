## [*]
## Check if running as ROOT, or exit from script.
##
## Params:
##   *: {String} Message.
##      Optional. Default: "This script must be run as root!".

if ! @is-root ; then
  local message="${*:-This script must be run as root!}"
  @error "$message"
fi
