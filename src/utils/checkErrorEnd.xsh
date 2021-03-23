## code [cmd]
## Check error and finish if `code` is bigger than 0 (error).
##
## Params:
##   code: {Integer} Exit code. Example: $?
##   cmd:  {String} Command to execute on error.
##         Optional.
##
## Example: @checkError $? "Invalid operation".

local code=$1
local cmd="$2"

if @isNumber "${code}"; then
  if [[ ${code} -gt 0 ]]; then
    # Error
    [ ! -z "${cmd}" ] && eval "${cmd}"
    @app.error '' true ${code}
  fi
else
  # Error
  [ ! -z "${cmd}" ] && eval "${cmd}"
  @app.error '' true ${code}
fi
