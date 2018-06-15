## script_name variable_name [note]
## Throw illegal error and exit.
##
## Params:
##   variable_name: {String} Parameter/Variable name.
##   note:          {String} Extra note about the error.
##                  Optional.

local variable_name="$1"
local note="$2"
local script_name="${FUNCNAME[2]}"
local msg
local line
local variable_value="$(eval "echo -e -n \"\$${variable_name}\"")"

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

@throw-invalid-state "
Invalid call of [${script_name}].
  > ${msg}
"
