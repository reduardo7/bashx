## path command
## Run with `sudo` if necessary.
##
## Params:
##   path:    {String} Related path for write permission is granted.
##   command: {String} Command to execute.

local path="$1"
local command="$2"

if [ -w "${path}" ]; then
  ( set -ex
    bash -c "${command}"
  )
else
  if type sudo >/dev/null 2>/dev/null
    then
      ( set -ex
        sudo bash -c "${command}"
      )
    else
      @error "sudo command not found"
    fi
fi
