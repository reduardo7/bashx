## message options [default]
## User choice.
##
## Params:
##   message: {String} Message.
##   options: {String} Options. Chars separated by a space.
##   default: {Char} Default value on non user input or invalid choice.
##            Optional. Default: "".
##
## Out: User selection or Default.
##
## Usage example:
##   @user.choice "Message..." "a b c" "b"

# Message
local message="$1"
# Options
local options=($2)
# Default result
local default="$3"

[ -z "$message" ] && @throw.invalidParam message
[ -z "$options" ] && @throw.invalidParam options

local result="$default"
local user_input

# Read
if ${BX_TTY}; then
  read -n 1 -p "$(@style)${BASHX_APP_PRINT_PREFIX} ${message} [${options}]: " user_input >&3
else
  @log.warn 'Not at TTY! choice cancelled...'
  echo "${default}"
  return 254
fi
echo >&3

# Validate input
user_input=$(@str.trim "${user_input}")
if [ ! -z "${user_input}" ]; then
  for option in ${options[@]}; do
    if [ "${option}" == "${user_input}" ]; then
      # Valid input
      result="${option}"
    fi
  done
fi

# Result
echo "${result}"

# vim: filetype=sh tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab
