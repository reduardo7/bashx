## functions_path [prefix]
## Generate *.sh functions from path.
##
## Params:
##   functions_path: {String} Path to scripts.
##   prefix:         {String} Prefix.
##                   Optional. Default: empty.

[[ "$-" == *x* ]] ; local _d_load_function=$? ; set +x

local functions_path="$1"
local prefix="$2"
local p='()'
local file_path

[ ! -z "${functions_path}" ] || @throw-invalid-param functions_path
[ -d "${functions_path}" ] || @throw-invalid-param functions_path 'Is not a valid path'

for file_path in ${functions_path}/*.sh ; do
  if [ -f "${file_path}" ]; then
    # Create base util function
    local n="$(@file-name "${file_path}" true)"
    local v="${n//-/_}" ; v="${v//\./_}"

    eval "
      __${prefix}${n}${p} {
        . \"${file_path}\"
      }

      ${prefix}${n}${p} {
        [[ \"\$-\" == *x* ]] ; local _d_${v}=\$? ; set +x
        __${prefix}${n} \"\$@\"
        local _r_${v}=\$?
        [[ \${_d_${v}} == 0 ]] && set -x
        return \${_r_${v}}
      }
    "
  fi
done

[[ ${_d_load_function} == 0 ]] && set -x
