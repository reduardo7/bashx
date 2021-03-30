## code [cmd]
## Check error.
##
## Params:
##   code: {Integer} Exit code. Example: $?
##   cmd:  {String} Command to execute on error.
##         Optional.
##
## Example: @checkError $? "error 'Invalid operation'".

local code=$1
local cmd="$2"

if @isNumber "${code}"; then
  if [[ ${code} -gt 0 ]]; then
    # Error
    eval "${cmd}"
  fi
else
  # Error
  eval "${cmd}"
fi

# vim: filetype=sh tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab
