## functions_path [prefix]
## Generate *.xsh functions from path.
##
## Params:
##   functions_path: {String} Path to scripts.
##   prefix:         {String} Prefix.
##                   Optional. Default: `functions_path` directory name.

{
  local _d_load_function_debug="$-"
} 2>/dev/null

local functions_path="$1"
local prefix="${2:-$(@file.name "${functions_path}" true).}"
local file_path

[ ! -z "${functions_path}" ] || @throw.invalidParam functions_path
[ -d "${functions_path}" ] || @throw.invalidParam functions_path 'Is not a valid path'

_function_load_v() {
  local n="$(@file.name "${1}" true)"
  echo "${prefix}${n}"
}

for file_path in "${functions_path}"/* ; do
  if [[ -f "${file_path}" ]] && [[ "${file_path}" = *".${BX_SCRIPT_EXTENSION}" ]]; then
    # Create base util function
    local n="$(_function_load_v "${file_path}")"

    # See @code.variableClean
    local v="${n//[^a-zA-Z0-9]/_}"

    eval "
      ${n}() {
        {
          local _d_${v}_debug=\"\$-\"
          set +x

          # Execution Watcher
          # https://tldp.org/LDP/Bash-Beginners-Guide/html/sect_12_02.html
          trap '{
            __BX_each_line \$?
          } 2>/dev/null' DEBUG
        } 2>/dev/null

        local this='${n}'
        local this_path='${file_path}'
        . \"${file_path}\"
        local _r_${v}=\$?

        {
          [[ \"\${_d_${v}_debug}\" == *x* ]] && set -x || true
        } 2>/dev/null
        return \${_r_${v}}
      }
    "
  elif [ -d "${file_path}" ]; then
    # Load functions from sub-path
    @function.load "${file_path}" "$(_function_load_v "${file_path}")."
  fi
done

{
  [[ "${_d_load_function_debug}" == *x* ]] && set -x || true
} 2>/dev/null

# vim: filetype=sh tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab
