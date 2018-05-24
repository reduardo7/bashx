local action="$1"
local name="$2"
local path="$3"
local script="${path}/${name}.sh"

if [ ! -z "${name}" ] && [ ! -z "${action}" ]; then
  case "${action}" in
    add) fwUtils.commonAction.add "${name}" "${path}" ;;
    remove) fwUtils.commonAction.remove "${name}" "${path}" ;;
    *) @warn 'Invalid action!' ;;
  esac
fi
