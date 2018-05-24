local action="$1"
local orig="$2"
local dest="$3"

case "${action}" in
  add) fwUtils.taskResource.add "${orig}" "${dest}" ;;
esac
