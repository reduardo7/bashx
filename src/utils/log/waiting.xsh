## timeout [message]
## Print the {message} every 0.25 seconds until the {timeout} is reached.
## This script blocks the execution (`sleep`) until the {timeout} is reached.
## Note: Overlay {message} can not be cancelled.
##
## Params:
##   timeout:  {Integer} Timeout in seconds. Should be bigger than 1.
##   message:  {String} Message to print every 0.25 seconds.
##             Optional. Default: "Please wait...".

local timeout=$1
local message="${2:-Please wait...}"
local to=$((timeout - 1))
local s
local ms

[[ $to -lt 1 ]] && @throw.invalidParam timeout

for s in $(seq 0 $to); do
  for ms in $(seq 0 25 75); do
    (
      sleep $s.$ms
      echo -e "\r" >&3
      @log "$message"
    ) &
  done
done

sleep $timeout
echo -e "\r\n\n" >&3

# vim: filetype=sh tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab
