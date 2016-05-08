# Check if running as ROOT, or exit from script.
#
# *: (Optional) Message.
if ! @is_root ; then
  if [ $# -eq 0 ] ; then
    local m="This script must be run as root!"
  else
    local m="$@"
  fi
  e "$m"
  e
  @end 1
fi
