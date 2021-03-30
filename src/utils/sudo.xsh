## path command
## Run with `sudo` if necessary.
## If {path} is not writable then run with `sudo`.
##
## Params:
##   path:    {String} Related path for write permission is granted.
##   command: {String} Command to execute.
##
## Return: Executed {command} exit code.

local path="$1"
local command="$2"

if ${BX_OS_IS_MINGW} || [ -w "${path}" ]; then
  ( set -ex
    bash -c "${command}"
  )
  return $?
else
  @required sudo
  ( set -ex
    sudo bash -c "${command}"
  )
  return $?
fi

# vim: filetype=sh tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab
