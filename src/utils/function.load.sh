## functions_path [prefix]
## Generate *.sh functions from path.
##
## Params:
##   functions_path: {String} Path to scripts.
##   prefix:         {String} Prefix.
##                   Optional. Default: empty.

{
  local _d_load_function_debug="$-"
} 2>/dev/null

local functions_path="$1"
local prefix="$2"
local p='()'
local file_path

[ ! -z "${functions_path}" ] || @throw.invalidParam functions_path
[ -d "${functions_path}" ] || @throw.invalidParam functions_path 'Is not a valid path'

for file_path in "${functions_path}"/*.sh ; do
  if [ -f "${file_path}" ]; then
    # Create base util function
    local n="$(@file.name "${file_path}" true)"
    local v="${n//-/_}" ; v="${v//\./_}"

    eval "
      ${prefix}${n}${p} {
        {
          local _d_${v}_debug=\"\$-\"
          set +x
        } 2>/dev/null

        . \"${file_path}\"
        local _r_${v}=\$?

        {
          [[ \"\${_d_${v}_debug}\" == *x* ]] && set -x || true
        } 2>/dev/null
        return \${_r_${v}}
      }
    "
  fi
done

{
  [[ "${_d_load_function_debug}" == *x* ]] && set -x || true
} 2>/dev/null
