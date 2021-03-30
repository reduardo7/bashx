local action="$1"
local name="$2"
local path="$3"
local script="${path}/${name}.${BX_SCRIPT_EXTENSION}"

if [[ ! -z "${name}" ]] && [[ ! -z "${action}" ]]; then
  case "${action}" in
    add) fwUtils.commonAction.add "${name}" "${path}" ;;
    remove) fwUtils.commonAction.remove "${name}" "${path}" ;;
    *) @log.warn 'Invalid action!' ;;
  esac
fi

# vim: filetype=sh tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab
