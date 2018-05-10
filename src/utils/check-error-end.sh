## code [cmd]
## Check error.
##
## Params:
##   code: {Integer} Exit code. Example: $?
##   cmd:  {String} Command to execute on error.
##         Optional.
##
## Example: @check-error $? "Invalid operation".

local code=$1
local cmd="$2"

if @is-number "${code}"; then
  if [[ ${code} -gt 0 ]]; then
    # Error
    [ ! -z "${cmd}" ] && eval "${cmd}"
    @error '' true ${code}
  fi
else
  # Error
  [ ! -z "${cmd}" ] && eval "${cmd}"
  @error '' true ${code}
fi
