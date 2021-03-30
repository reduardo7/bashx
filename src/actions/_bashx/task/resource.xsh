local action="$1"
local orig="$2"
local dest="$3"

case "${action}" in
  add) fwUtils.taskResource.add "${orig}" "${dest}" ;;
esac

# vim: filetype=sh tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab
