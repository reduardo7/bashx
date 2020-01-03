## [note]
## Throw not implemented error and exit.
##
## Params:
##   note:          {String} Extra note about the error.
##                  Optional.

local note="$1"
local script_name="${FUNCNAME[2]}"
local msg
local line

if [ ! -z "${note}" ]; then
  echo -e "${note}" | while read line ; do
    msg="${msg}\n  > ${line}"
  done
fi

@throw "@@@ [${script_name}] NOT IMPLEMENTED! @@@\n[${script_name}] is not implemented!${msg}"
