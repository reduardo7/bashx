# Check if running as ROOT, or exit from script.
#
# *: (Optional) Message.

if ! @is-root ; then
  if [ $# -eq 0 ] ; then
    local m='This script must be run as root!'
  else
    local m="$@"
  fi
  @error "$m"
fi
