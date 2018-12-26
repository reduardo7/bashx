## variable_name [note]
## Throw illegal error and exit.
##
## Params:
##   variable_name: {String} Parameter/Variable name.
##   note:          {String} Extra note about the error.
##                  Optional.

# Read variable value. Should be the first line of this function.
local variable_value="$(eval "echo -e -n \"\$${1}\"")"

local variable_name="$1"
local note="$2"
local script_name="${FUNCNAME[2]}"
local msg
local line

if [ "${script_name}" = 'source' ]; then
  script_name="${FUNCNAME[3]}"
fi

if [ -z "${variable_value}" ]; then
  msg="[${variable_name}] can not be emtpy"
else
  msg="Invalid value for [${variable_name}]: '${variable_value}'"
fi

if [ ! -z "${note}" ]; then
  echo -e "${note}" | while read line ; do
    msg="${msg}\n  > ${line}"
  done
fi

@throw-invalid-state "Invalid call of [${script_name}].\n  > ${msg}"
